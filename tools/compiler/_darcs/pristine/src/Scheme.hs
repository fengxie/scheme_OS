-- Scheme.hs --- short description

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

-- General scheme definitions here, deriving from r5rs.
-- TODO: finish the r5rs
-- TODO: support the r6rs

-- Code:

module Scheme where

import Data.Map(Map)
import qualified Data.Map as Map

-- Top level definition of scheme program
type Program = [Sentence]
type Identifier = Sym

data Definition = Defvar Sym Expr
                | Defun Sym [Sym] Body
                | Defun2 Sym [Sym] Sym Body
                | SeqDef [Definition]
                  deriving (Eq, Show)

data Sentence = NullSentence
              | Cmd Expr
              | Def Definition
              | TopBegin [Sentence]
              -- used as the debug info for define-syntax
              | DebugPatMatch (Map PatternId MacroArg)
              | DebugSyntaxDef SyntaxDef
                deriving (Eq, Show)

-- support syntax definition
data SyntaxDef = SyntaxDef {
                            macroName :: Sym,
                            transformSpec :: TransformSpec
                           }
               deriving (Eq, Show)

newSyntaxDef :: Sym -> TransformSpec -> SyntaxDef
newSyntaxDef = SyntaxDef

getMacroName :: SyntaxDef -> Sym
getMacroName = macroName

getTransformSpec :: SyntaxDef -> TransformSpec
getTransformSpec = transformSpec

data TransformSpec = TransformSpec {
                                    keywords :: [Sym],
                                    rules :: [SyntaxRule]
                                   }
                     deriving (Eq, Show)

newTransformSpec :: [Sym] -> [SyntaxRule] -> TransformSpec
newTransformSpec = TransformSpec

getKeywords :: SyntaxDef -> [Sym]
getKeywords = keywords . getTransformSpec

getRules :: SyntaxDef -> [SyntaxRule]
getRules = rules . getTransformSpec

getRule :: SyntaxDef -> Int -> SyntaxRule
getRule = (!!) . getRules

getRulesWith :: (SyntaxRule -> a) -> SyntaxDef -> [a]
getRulesWith f = (map f) . getRules

data SyntaxRule = SyntaxRule {
                              pattern :: Pattern,
                              template :: Template
                             }
                deriving (Eq, Show)

getPattern :: SyntaxRule -> Pattern
getPattern = pattern

getTemplate :: SyntaxRule -> Template
getTemplate = template

-- Each pattern id will be given a value when a macro is used
-- FIXME: this is just a temporary solution. A more subtle structure
-- should be introduced to solve this issue.
type MacroArg = [Expr]

type PatternId = Sym

type PatternDatum = Datum

data Pattern = PatId PatternId
             | PatList [Pattern]          -- (<pattern>*)
             | PatList2 [Pattern] Pattern -- (<pattern>* <pattern> ...)
             | PatSExp [Pattern] Pattern  -- (<pattern>* . <pattern>)
             | PatVec [Pattern]           -- #(<pattern>*)
             | PatVec2 [Pattern] Pattern  -- #(<pattern>* <pattern> ...)
             | PatDatum PatternDatum       -- (<expr>)
               deriving (Eq, Show)

data TemplateElm = TplElm Template
                 | TplElmEllipsis Template
                   deriving (Eq, Show)

data Template = TplId PatternId
              | TplElmList [TemplateElm]
              | TplElmSExp [TemplateElm] Template
              | TplVec [TemplateElm]
              | TplDatum PatternDatum
                deriving (Eq, Show)

-- 
data Sym = Nil
         | Sym String
           deriving (Eq, Show, Ord)

data Prefix = PreQuote
            | PreQuasiquote
            | PreComma
            | PreCommat         -- FIXME: change to PreCommAt
              deriving (Eq, Show)

data Datum = Void
           | Boolean Bool
           | Number Int         -- FIXME: change to Number Numb Bool
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
          | Branch Expr Expr Expr
          | Assign Sym Expr
          | Cond [(Expr, [Expr])]
          | Case Expr [([Datum], [Expr])] [Expr]
          | And [Expr]
          | Or [Expr]
          | Let [(Sym, Expr)] Body
            deriving (Eq, Show)
