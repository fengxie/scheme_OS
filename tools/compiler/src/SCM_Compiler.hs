-- Compiler.hs --- short description

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

-- This module is used to compile ABS Tree of Scheme code to virtual-machine
-- code. The code can be either feed to a virtual-machine interpreter and
-- the next stage of Scheme compiler which will convert it to final C code.

-- Code:

module Compiler
    (
     Instruction,
     ScmAss,
     compile
    ) where

import Scheme
import SVM2
import Builtin

import qualified Text.ParserCombinators.Parsec as P
import qualified Text.ParserCombinators.Parsec.Pos as Ppos
import qualified Text.ParserCombinators.Parsec.Error as Perr

import Monad

type Compiler a = P.GenParser Sentence CompilerSt a
type SCM_Compiler = Compiler ScmAss

data CompilerSt = CompilerSt {
                              label :: Int
                             }

initCompilerSt = CompilerSt {
                             label = 0
                            }

getLabel = label
setLabel l st = st {
                    label = l
                   }
updateLabel f st = st {
                       label = (label st)
                      }

labelPrefix = ".L_scm_"

genUniLabel :: Compiler String
genUniLabel = do
  label <- (P.getState >>= (return . getLabel))
  P.updateState (updateLabel (+1))
  return $ labelPrefix ++ (show label)

-- builtinFunctions = map (Variable . Sym) $ builtinFuncTab

program :: Compiler ScmAss
program = P.chainl (P.try expr) (return (++)) [makeInstr Nop]

compile = getResult . (P.runParser program initCompilerSt "")
    where
      getResult (Right r) = r
      getResult (Left e) = error (show e)

token :: (Sentence -> Maybe a) -> Compiler a
token test =
    P.token showToken posToken testToken
    where
      showToken = show
      posToken tok = Ppos.newPos "" 0 0
      testToken tok = test tok

expr :: Compiler ScmAss
expr = P.try (nullSentence >> (return []))
       P.<|>
        P.try (command >>= compileExpr)
       P.<|>
        P.try (definition >>= compileDef)

nullSentence = token (\tok -> case tok of
                                NullSentence -> Just NullSentence
                                _ -> Nothing)
command = token (\tok -> case tok of
                           Cmd exp -> Just exp
                           _ -> Nothing)

definition = token (\tok -> case tok of
                              Def definition -> Just definition
                              _ -> Nothing)

compileExpr :: Expr -> Compiler ScmAss
compileExpr (Variable sym) = return [makeInstr $ LookupVar sym]
compileExpr _ = fail "Unknown expression"

compileDef :: Definition -> Compiler ScmAss

compileDef (Defvar name exp) = (compileExpr exp) >>=
                               (return . ((flip mergeSource) [makeInstr $ NewBind name, makeInstr Nop]))
compileDef (Defun name args (Body _ body)) =
    do
      c <- foldM (\a b -> compileExpr b >>= (return . (a++))) [] body
      return $ [MakeClosure name (Args args) (header ++ c ++ [LeaveProc]),
                NewBind name,
                Nop]
    where
      header = concatMap (\(v, i) -> [AccStack i, ReBind v]) (zip args [0..(length args)])
            
compileDef _ = return []
