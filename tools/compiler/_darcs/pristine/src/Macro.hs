
module Macro
    (
     transform
    )
    where

import Exptype

import Maybe
import List
import Control.Monad.State
import Control.Monad.Error

type Pattern = Expr
type Template = Expr

data Syntax = Syntax {
                      identifier :: Sym,
                      keywords :: [Sym],
                      rules :: [(Pattern, Template)]
                     }

data ErrorType = NoError
               deriving (Show)

-- consider the analyse of macro a part of parser
data ParseError = Err {
                       etype :: ErrorType,
                       msg :: String
                      }
                deriving (Show)

noError = Err {
               etype = NoError,
               msg = ""
              }
          
instance Error ParseError where
    noMsg = noError
    strMsg s = noError { msg = s }

predefinedId = [
                Sym "define-syntax",
                Sym "let-syntax"
               ]
               
data Envt = Envt {
                  syntaxes :: [Syntax]
                 }

getSyntax sym = (find ((== sym) . identifier)) . syntaxes
addSyntax syn envt = envt {
                           syntaxes = syn : (syntaxes envt)
                          }
                     
data Transformer = Transformer {
                                envt :: Envt
                               }
                     
transform :: [Expr] -> [Expr]
transform = id