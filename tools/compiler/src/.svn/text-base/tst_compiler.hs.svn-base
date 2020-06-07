
module Main where

import Compiler
import Scmlex(alexScanTokens)
import Parser(scmParser)

-- test s = do
--   l1 <- getLabel
--   changeLabel
--   return l1
  
main = do
  s <- getContents
  ((mapM_ print) . compile . scmParser . alexScanTokens) s