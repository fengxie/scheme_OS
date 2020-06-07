
module Main where

import Convert
import Compiler
import Macro
-- TODO: Use SCM_Lex & SCM_Parser instead.
import Scmlex(scanTokens)
import Parser(scmParser)

import qualified System.Console.GetOpt as GetOpt
import qualified Control.Monad.ST as St
import qualified Text.Regex as Regex
import Maybe
import System
import IO

data ScmOpt = OutputFile String
            | InputFile String
            | LibDir String
            | CFlags [String]    -- For C compiler
            | Flag String Bool
              deriving (Show)

options = [
           GetOpt.Option ['o']
                     ["output-file"]
                     (GetOpt.ReqArg OutputFile "FILE")
                     "Specify output file"
          ,
           GetOpt.Option ['C'] [] (GetOpt.NoArg $ Flag "C" True) "stop after generating C"
          ,
           GetOpt.Option ['L'] ["lib-dir"]
                     (GetOpt.ReqArg LibDir "DIR" )
                     "stop after generating C"
          ,
           GetOpt.Option [] ["c-flags"] (GetOpt.ReqArg (CFlags . words)  "STRING") "c flags"
          ]

data ScmOptions = ScmOptions {
                              ofile :: String,
                              ifile :: String,
                              libDir :: String,
                              cFlags :: [String],
                              cOnly :: Bool
                             }
                  deriving (Show)

defaultOptions = ScmOptions {
                             ofile = "a.out",
                             ifile = "",
                             libDir = "",
                             cFlags = ["-lscheme"],
                             cOnly = False
                            }

putOutFile opts outf = opts { ofile = outf }
putInFile opts inf = opts { ifile = inf }
putCFlags opts flags = opts { cFlags = flags }
addCFlag opts flag = opts { cFlags = flag : (cFlags opts) }

analyzeArgs :: [String] -> ([ScmOpt], [String], [String])
analyzeArgs = GetOpt.getOpt GetOpt.Permute options 

processOpts :: ([ScmOpt], [String], [String]) -> ScmOptions
processOpts (opts, nonOpts, errors) = processOpts' opts defaultOptions'
    where
      defaultOptions' = case nonOpts of
                          [] -> defaultOptions
                          (inf: opts) -> defaultOptions { ifile = inf, cFlags = opts }
      processOpts' [] initOpts = initOpts
      processOpts' (OutputFile f: opts) initOpts = processOpts' opts (initOpts { ofile = f })
      processOpts' (LibDir d: opts) initOpts = processOpts' opts (initOpts { libDir = d })
      processOpts' (CFlags flags: opts) initOpts =
          processOpts' opts (initOpts { cFlags = (cFlags initOpts) ++ flags })
      processOpts' (Flag "C" True: opts) initOpts = processOpts' opts (initOpts { cOnly = True, ofile = outf })
          where
            -- -o option can override -C
            outf = if (ofile initOpts) == "a.out"
                   then
                       Regex.subRegex (Regex.mkRegex ".scm$") (ifile initOpts) ".c"
                   else
                       ofile initOpts

formatCsrc f indentOpt= system $ unwords ["indent", f, indentOpt]

compileScm options = do
  hInFile <- openFile (ifile options) ReadMode
  s <- hGetContents hInFile
  hTmp <- openFile tmp_file WriteMode
  putStrLn $ (ifile options) ++ " -> " ++ (ofile options)
  ((mapM_ (hPutStrLn hTmp)) . (convert mod_name) . compile . transform . scmParser . scanTokens) s
  hClose hTmp
  formatCsrc tmp_file "-br -brs -fca -kr -nut"
  case (cOnly options) of
    False -> do
        putStrLn $ cc_cmd tmp_file (ofile options) (cFlags options)
        system $ cc_cmd tmp_file (ofile options) (cFlags options)
    _ -> return ExitSuccess
  hClose hInFile
    where
      mod_name = Regex.subRegex (Regex.mkRegex ".scm$") (ifile options) ""
      tmp_file = if (cOnly options) then (ofile options)
                 else "/tmp/_scm_temp" ++ ".c"
      cc_cmd inf outf cflag = "gcc " ++ (unwords cflag) ++  " -o " ++
                              outf ++ " " ++ inf ++ " -lscheme"

main = do
  args <- getArgs
  putStrLn $ (show . processOpts . analyzeArgs) args
  compileScm $ processOpts . analyzeArgs $ args
