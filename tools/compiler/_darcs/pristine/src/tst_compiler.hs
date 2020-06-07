
module Main where

import Compiler
import Scmlex(scanTokens)
import Parser(scmParser)

-- test s = do
--   l1 <- getLabel
--   changeLabel
--   return l1
  
main = do
  s <- getContents
  ((mapM_ print) . compile . scmParser . scanTokens) s