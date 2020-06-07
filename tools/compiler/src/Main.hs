
module Main where

import Convert
import Compiler
import Scmlex(alexScanTokens)
import Parser(scmParser)

import qualified Control.Monad.State as St

import System

main = do
  args <- getArgs
  print args