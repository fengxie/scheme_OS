
module Main where

import Scmlex(alexScanTokens)
import Parser(scmParser)

printList = mapM_ print

main = do
  s <- getContents
  (printList . scmParser . alexScanTokens) s