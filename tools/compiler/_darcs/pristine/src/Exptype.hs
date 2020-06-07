
module Exptype where

data Sym = Nil
         | Sym String
           deriving (Eq, Show)

data Prefix = PreQuote
            | PreQuasiquote
            | PreComma
            | PreCommat         -- FIXME: change to PreCommAt
              deriving (Eq, Show)

data Datum = Void
           | Boolean Bool
           | Number Int         -- FIXME: change to NumberD NumberT Bool
           | Character Char
           | String [Char]
           | Symbol Sym
           | List [Datum]
           | SExp [Datum] Datum -- (<data> . <datum>)
           | Abbrev Prefix Datum
           | Vector [Datum]
             deriving (Eq, Show)

listToSExp nil@(List []) = nil
listToSExp (List (d:ds)) = SExp [listToSExp d] (listToSExp $ List ds)
listToSExp (SExp [] _) = error "Compiler inner error, wrong S-expr format"
listToSExp s@(SExp (d:[]) _) = s
listToSExp (SExp (d:ds) last) = SExp [listToSExp d] (listToSExp $ SExp ds last)
listToSExp atom = atom
-- listToSExp _ = error "listToSExp can only process list"

data Formals = Args [Sym]
             | Args2 [Sym] Sym
               deriving (Eq, Show)
data Body = Body [Expr] [Expr]
            deriving (Eq, Show)
data Expr = Variable Sym
          | Quote Datum
          | SelfEval Datum
          | ProcCall Expr [Expr]
          | Sequence [Expr]
          | Lambda Formals Body
          | Defvar Sym Expr
          | Defun Sym [Sym] Body
          | Defun2 Sym [Sym] Sym Body
          | Branch Expr Expr Expr
          | Assign Sym Expr
          | Cond [(Expr, [Expr])]
          | Case Expr [([Datum], [Expr])] [Expr]
          | And [Expr]
          | Or [Expr]
          | Let [(Sym, Expr)] Body
            deriving (Eq, Show)

