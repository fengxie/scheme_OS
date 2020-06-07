
module Compiler
    (
     Code(..),
     CodeM,
     compile
     -- getLabel,
     -- changeLabel
    ) where

import Exptype
import SVM
import Builtin

import Monad

newtype CodeM code = CodeM (Int -> (Int, code))

concatMapM :: (Monad m) => (a -> m [b]) -> [a] -> m [b]
concatMapM f = (liftM  concat) . (mapM f)

instance Monad CodeM where
    return code = CodeM (\label -> (label, code))
    CodeM code >>= action = CodeM code'
        where
          code' label =
              let (label', c) = code label
                  CodeM code'' = action c
              in
                code'' label'

-- instance Show CodeM  where
--     show (CodeM code) =
--         let (l, c) = code 0
--         in
--           ""
-- same helper functions
labelPrefix = ".L_scm_"

builtinFunctions = map (Variable . Sym) $ builtinFuncTab

getLabel :: CodeM [Char]
getLabel = CodeM (\label -> (label + 1, labelPrefix ++ (show label)))

returnCodeM :: CodeM [Code] -> Int -> [Code]
returnCodeM (CodeM code) = snd . code

codeBlock :: Bool -> CodeM ([Code], [Code])
codeBlock istail =
    case istail of
      False -> do
        label <- getLabel
        return $ ([PushCont label], [Label label])
      True -> return $ ([], [])

compileSeq :: Bool -> [Expr] -> CodeM [[Code]]
compileSeq istail [] = return []
compileSeq istail (exp:exps)
    | exps == [] =
        do
          code <- compileExprM istail exp
          return $ [code]
    | otherwise =
        do
          code <- compileExprM False exp
          rest_code <- compileSeq istail exps
          return $ code : rest_code

compileExprM :: Bool -> Expr -> CodeM [Code]

-- variable
compileExprM _ (Variable sym) =
    return [LookupVar sym]

-- literal value
compileExprM _ (Quote datum) =
    return [FetchConst datum]
compileExprM _ (SelfEval datum) =
    return [FetchConst datum]

-- procedure call
compileExprM istail (ProcCall func args) =
    do
      (h, t) <- codeBlock istail
      operands <- compileSeq False args
      if (elem func builtinFunctions)
       then
           return $ (concatMap (\x -> x ++ [Push, BlankLn]) operands) ++
                      [CallBuiltin (varGetSym func) (length args),
                       MoveSp (length args), BlankLn]
       else do operator <- compileExprM False func
               return $ h ++ (concatMap (++ [Push, BlankLn]) operands) ++
                      operator ++ [Apply] ++ t ++ [BlankLn]
    where
      varGetSym (Variable sym) = sym
      varGetSym _ = error "Compiler.hs: unexcepted value"

-- (begin <sequence>)
compileExprM istail (Sequence exps) =
    do
      codes <- compileSeq istail exps
      return $ concat codes

-- (lambda <formals> <body>)
compileExprM _ (Lambda formals (Body _ body)) =
  (compileExprM True (Sequence body))
  >>= \c -> return $ [MakeClosure Nil formals (c ++ [LeaveProc])]

-- (define <var> <expr>)
compileExprM _ (Defvar name exp) =
    do
      c <- compileExprM False exp
      return $ c ++ [NewBind name, Nop]

-- (define <args> <body>)
compileExprM _ (Defun name args (Body _ body)) =
    do
      c <- compileExprM True (Sequence body)
      return $ [MakeClosure name (Args args) (header ++ c ++
                                              [LeaveProc]),
                NewBind name,
                Nop]
    where
      header = concatMap (\(v, i) -> [AccStack i, ReBind v]) (zip args [0..(length args)])

compileExprM _ (Defun2 name args larg (Body _ body)) =
    do
      c <- compileExprM True (Sequence body)
      return $ [MakeClosure name (Args2 args larg) (c ++ [LeaveProc]),
                NewBind name,
                Nop]

-- (set! <var> <expr>)
compileExprM _ (Assign var exp) =
    do
      c <- compileExprM False exp
      return $ c ++ [ReBind var, Nop]

-- (if <test> <then> <else>)
compileExprM istail (Branch test then_exp else_exp) = 
    do
      c_test <- compileExprM False test
      c_then <- compileExprM istail then_exp
      c_else <- compileExprM istail else_exp
      return (c_test ++ [IfTrue c_then c_else])

compileExprM istail (Cond clauses) =
    do
      label_end <- getLabel
      c <- concatMapM (compileClause label_end) clauses
      return $ c ++ [FetchConst Void, Label label_end]
    where
      compileClause label (tst, seq) = do
        t <- compileExprM False tst
        a <- compileExprM istail (Sequence seq)
        return (t ++ [IfTrue (a ++ [Goto label]) []])

-- concatMapM
-- mapM
-- (and <expr>*)
-- (and) => #t
compileExprM _ (And []) = return [FetchConst $ Boolean True]
compileExprM istail (And exps) =
    do
      codes <- compileSeq istail exps
      lend <- getLabel
      return $ (removeLast (concatMap (\c -> c ++ [IfFalse [Goto lend] []]) codes))
                 ++ [Label lend]
    where
      removeLast xs = take ((length xs) - 1) xs

-- (or <expr>*)
-- (or) => #f
compileExprM _ (Or []) = return [FetchConst $ Boolean False]
compileExprM istail (Or exps) =
    do
      codes <- compileSeq istail exps
      lend <- getLabel
      return $ (removeLast (concatMap (\c -> c ++ [IfTrue [Goto lend] []]) codes))
                 ++ [Label lend]
    where
      removeLast xs = take ((length xs) - 1) xs

compileExprM _ e@(_) = error $ "Unsupported syntax: " ++ (show e)
    
-- compile :: [Expr] -> [Code]
-- compile exps = (returnCodeM (compileExprM True (Sequence exps))) 0

-- compile :: (Operand op) => [Expr] -> [SvmInstr op]
compile exps = map (putInstr (putInfo emptyInstr Info)) $
               (returnCodeM (compileExprM True (Sequence exps))) 0

-- convertCode :: [Code] -> IO ()
