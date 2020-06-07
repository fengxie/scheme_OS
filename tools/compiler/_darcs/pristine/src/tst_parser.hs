
module Main where

import SCM_Lex(scanTokens)
import SCM_Parser(scmParser)

printList = mapM_ print

main = do
  s <- getContents
  (printList . scmParser . scanTokens) s