
module Main where

import Convert
import Compiler
import Scmlex(alexScanTokens)
import Parser(scmParser)

import qualified Control.Monad.State as St

-- returnData code = St.evalState (code2c code) (CData (EnvtFrame NullEnvt []) 0 0)

main = do
  s <- getContents
  ((mapM_ putStrLn) . (convert "test") . compile . scmParser . alexScanTokens) s
  -- print $ returnData [] getEnvt
  
