
module Main(main) where

import Scmlex

printList [] = do
  print "end"
printList (x:xs) = do
  print x
  printList xs

main = do
  s <- getContents
  printList (alexScanTokens s)
