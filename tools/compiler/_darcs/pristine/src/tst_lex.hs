
module Main(main) where

import SCM_Lex 

printList [] = return ()
printList (x:xs) = do
  print x
  printList xs

main = do
  s <- getContents
  printList (scanTokens s)
