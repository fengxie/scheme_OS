
module Builtin(
               builtinFuncTab,
               mapBuiltin,
               )
    where

builtinFunc_List = ["null?", "car", "cdr", "cons"]
builtinFunc_Numb = ["+", "-", "*", "/"]
builtinFunc_Misc = ["display",
                    "psvmst"]

builtinFuncTab = builtinFunc_List ++
                 builtinFunc_Numb ++
                 builtinFunc_Misc

sepcialfuncMap = [
           ("+", "add"),
           ("-", "sub"),
           ("*", "mul"),
           ("/", "div"),
           ("set!", "set"),
           ("null?", "null_p")
                 ]

-- map builtin function to its C implementation macro name
mapBuiltin fun =
    case (lookup fun sepcialfuncMap) of
      (Just f) -> f
      Nothing -> fun
