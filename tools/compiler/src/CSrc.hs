
module CSrc where

import Builtin

funCall :: String -> [String] -> String
funCall func [] = func ++ "()"
funCall func args =
    func ++ "(" ++ ((tail . concatMap ("," ++)) args) ++ ")"

funCallE :: String -> [String] -> String
funCallE =  ((++ ";") .) . funCall

ifExpr :: String -> [String] -> [String] -> [String]
ifExpr cond con_seq alt_seq =
    ["if (" ++ cond ++ ") {"] ++ con_seq ++ ["}"] ++ else_code
    where
      else_code = if alt_seq == []
                  then []
                  else ["else {"] ++ alt_seq ++ ["}"]
                              

typeCast :: String -> String -> String
typeCast t obj = "(SCHEME_CTYPE(" ++ t ++ ") *)" ++ obj

funCallBuiltin :: String -> Int -> String
funCallBuiltin fun argc = funCallE ("M_builtin_" ++ (mapBuiltin fun)) [show argc]

cStatement :: String -> String
cStatement = (++ ";")