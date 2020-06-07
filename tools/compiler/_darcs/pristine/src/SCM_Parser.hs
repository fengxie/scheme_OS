-- SCM_Parser.hs --- short description

-- Copyright  (C)  2006  Fung Tse <wikeithtse@gmail.com>

-- Version: 1.0
-- Keywords: 
-- Author: Fung Tse <wikeithtse@gmail.com>
-- Maintainer: Fung Tse <wikeithtse@gmail.com>
-- URL: http://

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-- 02111-1307, USA.

-- Commentary: 



-- Code:

-- New Parser for scheme using Parsec
--
-- TODO:
--   support R6RS

module SCM_Parser (scmParser)
    where

import Monad
import qualified Data.Map as Map

import qualified Text.ParserCombinators.Parsec as P
import qualified Text.ParserCombinators.Parsec.Pos as Ppos
import qualified Text.ParserCombinators.Parsec.Error as Perr

import qualified SCM_Lex as L
import Scheme

import ParserGen


-- Parsers for tokens
leftPar = $(tokenParserGen "Leftpar")
rightPar = $(tokenParserGen "Rightpar")
leftSharpar = $(tokenParserGen "Leftsharpar")
quote = $(tokenParserGen "Quote")
point = $(tokenParserGen "Point")
elsep = $(tokenParserGen "Else")
rightArrow = $(tokenParserGen "Rightarrow")
define = $(tokenParserGen "Define")
tokDefineSyntax = $(tokenParserGen "DefineSyntax")
tokSyntaxRules = $(tokenParserGen "SyntaxRules")
unquote = $(tokenParserGen "Unquote")
unquoteSplicing = $(tokenParserGen "Unquotesplicing")
expQuote = $(tokenParserGen "Exp_quote")
expLambda = $(tokenParserGen "Exp_lambda")
expIf = $(tokenParserGen "Exp_if")
expSet = $(tokenParserGen "Exp_set")
expBegin = $(tokenParserGen "Exp_begin")
expCond = $(tokenParserGen "Exp_cond")
expAnd = $(tokenParserGen "Exp_and")
expOr = $(tokenParserGen "Exp_or")
expCase = $(tokenParserGen "Exp_case")
letp = $(tokenParserGen "Let")
letstar = $(tokenParserGen "Letstar")
letrec = $(tokenParserGen "Letrec")
tokDo = $(tokenParserGen "Do")
tokDelay = $(tokenParserGen "Delay")
tokQuasiQuote = $(tokenParserGen "Quasiquote")


--
program :: Parser Program
program = P.many $ (P.try sentence) P.<|> syntaxDef

sentence :: Parser Sentence
sentence = (P.try expr >>= (return . Cmd))
           P.<|>
           (P.try definition >>= (return . Def))
           P.<|>
            do {
                leftPar; expBegin;
                seq <- P.many1 sentence;
                rightPar;
                return $ TopBegin seq
               }

  
transform :: Template -> Map.Map PatternId MacroArg -> Sentence
transform t binding = Cmd $ transform' t binding
    where
      transform' :: Template -> Map.Map PatternId MacroArg -> Expr
      transform' (TplId tId) binding | Map.member tId binding = head (binding Map.! tId)
                                     | otherwise = Variable tId

transformer :: SyntaxDef -> (Identifier, Parser Sentence)
transformer syntax = (getMacroName syntax, newParser)
    where
      newParser = let parsers = getRulesWith (P.try . syntaxRule2Parser) syntax
                  in do {
                         template <- P.choice parsers;
                         binding <- getMacroBindingM;
                         return $ transform template binding
                        }
                  P.<?>
                       -- FIXME: make the error message more readable
                       (fail "parse error")                   
      addMacroArgWithM_ :: (PatternId -> Expr -> PState -> PState) -> PatternId -> Expr -> Parser ()
      addMacroArgWithM_  f patId e = do
        ps <- P.getState
        case (hasMacroArg patId ps) of
          True -> fail $ "syntax-rules: variable used twice in pattern in:" ++ (show patId)
          _ -> P.updateState $ f patId e
      -- 
      -- generate new parser from pattern
      --
      -- if success, return corresponding template of this pattern
      syntaxRule2Parser :: SyntaxRule -> Parser Template
      syntaxRule2Parser rule = do
        resetMacroBindingM
        pattern2ParserWith addMacroArg (getPattern rule)
        return $ getTemplate rule
      -- help function for `pattern2Parser
      pattern2ParserWith :: (PatternId -> Expr -> PState -> PState) -> Pattern -> Parser ()
      pattern2ParserWith f (PatId patId) = expr >>= (addMacroArgWithM_ f patId)
      pattern2ParserWith f (PatList pats) = mapM_ (pattern2ParserWith f) pats
      pattern2ParserWith f (PatList2 pats patE) =
          mapM_ (pattern2ParserWith f) pats >> (P.skipMany $ pattern2ParserWith addMacroArg2 patE)

addSyntaxDefM_ :: SyntaxDef -> Parser ()
addSyntaxDefM_ = P.updateState . addSyntaxDef . transformer

infix 9 >>>=

(>>>=) :: (Monad m) => m a -> m b -> m a
(>>>=) ma mb = ma >>= (mb >>) .  return

-- How to support syntax definition?
-- the parser syntaxDef don't have to return the abs tree of syntax def, but,
-- instead, add a new `parser' into the top level parser. This new
-- parser can be used to parser consequence derived expressions.
syntaxDef :: Parser Sentence
syntaxDef = do
  leftPar
  tokDefineSyntax
  keyword <- identifier
  trans <- transformerSpec
  rightPar
  addSyntaxDefM_ $ newSyntaxDef keyword trans
  return $ DebugSyntaxDef $ newSyntaxDef keyword trans
  where
    pattern :: Parser Pattern
    pattern = (P.try $ identifier >>= (return . PatId))
              P.<|>
              (P.try $ primDatum >>= (return . PatDatum))
              P.<|>
              (P.try $ leftPar >> P.many pattern >>>= rightPar >>= (return . PatList))
              -- TODO: support full pattern definition
              -- FIXME: more suitable error message
              P.<?>
              "pattern"
    template :: Parser Template
    template = (P.try $ identifier >>= (return . TplId))
               P.<|>
               (P.try $ primDatum >>= (return . TplDatum))
               P.<|>
               (P.try $ leftPar >> P.many template >>>= rightPar >>= (return . TplElmList . (map TplElm)))
              -- FIXME: more suitable error message
               P.<?>
               "template"
    syntaxRule :: Parser SyntaxRule
    syntaxRule = do
              leftPar
              pat <- pattern
              tpl <- template
              rightPar
              return $ SyntaxRule pat tpl
    transformerSpec :: Parser TransformSpec
    transformerSpec = do
              leftPar
              tokSyntaxRules
              leftPar
              keywords <- P.many identifier
              rightPar
              rules <- P.many syntaxRule
              rightPar
              return $ newTransformSpec keywords rules

-- 
-- Syntax rules for expression
-- 
expr :: Parser Expr
expr = variable
       P.<|>
        literal
       P.<|>
        quotation
       P.<|>
        (P.try procCall)
       P.<|>
        (P.try lambda)
       P.<|>
        (P.try ifExpr)
       -- P.<|>
       --  (P.try assignment)
       -- P.<|>
       --  (P.try derivedExpr)

literal :: Parser Expr
literal = do {
              d <- primDatum;
              return $ SelfEval d
             }
          P.<|>
           quotation

identifierP :: (Sym -> Bool) -> Parser Sym
identifierP f = token test
    where
      getSym (Symbol sym) = sym
      test tok | L.isSymbol tok && (f . getSym . L.getDatum) tok = Just $ (getSym . L.getDatum) tok
               | otherwise = Nothing

identifier :: Parser Sym
identifier = identifierP (\_ -> True)

uniIdentifier :: String -> Parser Sym
uniIdentifier = identifierP . (==) . Sym

ellipsis :: Parser Sym
ellipsis = uniIdentifier "..."

variable :: Parser Expr
variable = identifier >>= (return . Variable)

quotation :: Parser Expr
quotation = do
  quote
  d <- datum
  return $ Quote d

procCall :: Parser Expr
procCall = do {
               leftPar;
               op <- operator;
               args <- operands;
               rightPar;
               return $ ProcCall op args
              }
    where
      operator = expr
      operands = P.many expr

lambda :: Parser Expr
lambda = do {
             leftPar;
             expLambda;
             f <- formals;
             b <- body;
             rightPar;
             return $ Lambda f b
            }

ifExpr :: Parser Expr
ifExpr = do {
             leftPar;
             expIf;
             test <- expr;
             consequent <- expr;
             alternate <- expr; -- FIXME: 1/0 expression here
             rightPar;
             return $ Branch test consequent alternate
            }
             

-- Parser for data
primDatum :: Parser Datum
primDatum = token test
    where
      test tok | L.isPrimData tok = Just $ L.getDatum tok
               | otherwise = Nothing

datum :: Parser Datum
datum = primDatum
        P.<|>
         (P.try list)
        P.<|>
         (P.try sexp)
    where
      list = do {
                 leftPar;
                 lst <- P.many datum;
                 rightPar;
                 return $ List lst
                }
      sexp = do {
                 leftPar;
                 lst <- P.many1 datum;
                 point;
                 d <- datum;
                 rightPar;
                 return $ SExp lst d
                }

formals :: Parser Formals
formals = (identifier >>= (return . (Args2 [])))
          P.<|>
           P.try args
          P.<|>
           P.try args2
    where
      args = do {
                 leftPar;
                 args <- P.many identifier;
                 rightPar;
                 return $ Args args
                }
      args2 = do {
                  leftPar;
                  args <- P.many1 identifier;
                  point;
                  rest <- identifier;
                  rightPar;
                  return $ Args2 args rest
                 }
               

body :: Parser Body
body = P.many1 expr >>= (return . (Body []))

--
-- Syntax rules for program and definition
--
definition :: Parser Definition
definition = (P.try defvar)
             P.<|>
             (P.try defun)
             P.<|>
             ((P.try seqDef) >>= return . SeqDef)
    where
      defvar = do {
                   leftPar;
                   define;
                   var <- identifier;
                   exp <- expr;
                   rightPar;
                   return $ Defvar var exp
                  }
      defun = do {
                  leftPar;
                  define;
                  leftPar;
                  name <- identifier;
                  args <- defFormals;
                  rightPar;
                  b <- body;
                  rightPar;
                  case args of
                    (x, False) -> return $ Defun name x b
                    (x:xs, True) -> return $ Defun2 name xs x b
                 }
      defFormals = (P.try formals2)
                   P.<|>
                   (P.many identifier >>= \x -> return (x, False))
          where
            formals2 = do {
                           vars <- P.many identifier;
                           point;
                           rest <- identifier;
                           return $ (rest: vars, True)
                          }
      seqDef = do {
                   leftPar;
                   expBegin;
                   defs <- P.many definition;
                   rightPar;
                   return defs
                  }


-- TODO: should return with error
scmParser :: [L.Token] -> Program
scmParser = getResult . (P.runParser program initParserState "")
    where
      getResult (Right r) = r
      getResult (Left e) = error (show e)
