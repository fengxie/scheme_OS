--
-- Lexical syntax for Scheme(r5rs)
--

{
module Scmlex (Token(..), AlexPosn(..), alexScanTokens, getToken) where

import Char (toLower)
}

%wrapper "posn"

$digit = 0-9
$letter = [a-zA-Z]

$leftpar = \(
$rightpar = \)
@leftsharpar = "#("
$quote = \'
$quasiquote = `
$point = \.
$comma = \,
@commat = ",@"

$specialInit = [!\$\%&\*\/:\<=>\?\^_\~]
$initial = [$letter $specialInit]
$peculiarId = [\+\-\*\/]
$specialSub = [\+\-\.\@]
$subsequent = [$initial $digit $specialSub]

@identifier = $initial ($subsequent)*
	    | $peculiarId
@true	    = "#t"
@false	    = "#f"
@boolean    = @true
	    | @false
@char	    = "#\" .
	    | "#\space"
	    | "#\newline"
@stringelm  = (. # [\"\\])
	    | \\\"
	    | \\\\
@string     = \" (@stringelm)* \"

-- definition for number
@sign	    = ""
	    | \+
	    | \-
@exactness  = ""
	    | \#i
	    | \#e
@radix2	    = \#b
@radix8	    = \#o
@radix10    = ""
	    | \#d
@radix16    = \#x

$digit2	    = [01]
$digit8	    = [0-8]
$digit10    = $digit
$digit16    = [$digit10 a-f A-F]

$exponent   = [esfdl]
@suffix	    = ""
	    | $exponent @sign ($digit10)+

@prefix2    = @radix2 @exactness
	    | @exactness @radix2
@prefix8    = @radix8 @exactness
	    | @exactness @radix8
@prefix10   = @radix10 @exactness
	    | @exactness @radix10
@prefix16   = @radix16 @exactness
	    | @exactness @radix16
@uinteger2  = ($digit2)+ (\#)*
@uinteger8  = ($digit8)+ (\#)*
@uinteger10 = ($digit10)+ (\#)*
@uinteger16 = ($digit16)+ (\#)*
@decimal10  = @uinteger10 @suffix
	    | \. ($digit10)+ (\#)* @suffix
	    | ($digit10)+ \. ($digit10)* (\#)* @suffix
	    | ($digit10)+ (\#)+ \. (\#)* @suffix
@ureal2	    = @uinteger2
	    | @uinteger2 \/ @uinteger2
@ureal8	    = @uinteger8
	    | @uinteger8 \/ @uinteger8
@ureal10    = @uinteger10
	    | @uinteger10 \/ @uinteger10
	    | @decimal10
@ureal16    = @uinteger16
	    | @uinteger16 \/ @uinteger16
@real2	    = @sign @ureal2
@real8	    = @sign @ureal8
@real10	    = @sign @ureal10
@real16	    = @sign @ureal16
@complex2   = @real2
	    | @real2 \@ @real2
@complex8   = @real8
	    | @real8 \@ @real8
@complex10  = @real10
	    | @real10 \@ @real10
@complex16  = @real16
	    | @real16 \@ @real16
@number2    = @prefix2 @complex2
@number8    = @prefix8 @complex8
@number10   = @prefix10 @complex10
@number16   = @prefix16 @complex16
@number	    = @number2
	    | @number8
	    | @number10
	    | @number16

tokens :-

       ";".* 			; -- comment
       $white+			;
       $leftpar			{ \p _ -> Leftpar p }
       $rightpar		{ \p _ -> Rightpar p }
       @leftsharpar		{ \p _ -> Leftsharpar p }
       $point                   { \p _ -> Point p }
       $quote			{ \p _ -> Quote p }
       -- syntactic keywords
       "else"			{ \p _ -> Else p }
       "=>"			{ \p _ -> Rightarrow p }
       "define"			{ \p _ -> Define p }
       "`"                      { \p _ -> Quasiquote p }
       "quasiquote"		{ \p _ -> Quasiquote p }
       "unquote"		{ \p _ -> Unquote p }
       ","			{ \p _ -> Unquote p }
       "unquote-splicing"	{ \p _ -> Unquotesplicing p }
       ",@"			{ \p _ -> Unquotesplicing p }
       -- Expression keywordsnn
       "quote"			{ \p _ -> Exp_quote p }
       "lambda"		 	{ \p _ -> Exp_lambda p }
       "if"		 	{ \p _ -> Exp_if p }
       "set!"		 	{ \p _ -> Exp_set p }
       "begin"		 	{ \p _ -> Exp_begin p }
       "cond"		 	{ \p _ -> Exp_cond p }
       "and"		 	{ \p _ -> Exp_and p }
       "or"		 	{ \p _ -> Exp_or p }
       "case"		 	{ \p _ -> Exp_case p }
       "let"		 	{ \p _ -> Let p }
       "let*"		 	{ \p _ -> Letstar p }
       "letrec"		 	{ \p _ -> Letrec p }
       "do"		 	{ \p _ -> Do p }
       "delay"		 	{ \p _ -> Delay p }
       @identifier		{ \p s -> Id p (map toLower s) }
       @true			{ \p _ -> Boolean p True }
       @false			{ \p _ -> Boolean p False }
       @char			{ \p s -> Character p $
				          case s of
					    "#\\space" -> ' '
					    "#\\newline" -> '\n'
					    _ -> (head . tail . tail) s }
       @string			{ \p s -> String p (getString s) }
       @sign @uinteger10	{ \p s -> Number p (read s) }
       
{
data Token =
     	    Leftpar AlexPosn
	    | Rightpar AlexPosn
	    | Leftsharpar AlexPosn
	    | Quote AlexPosn
            | Point AlexPosn
	    | Else AlexPosn
	    | Rightarrow AlexPosn
	    | Define AlexPosn
	    | Unquote AlexPosn
	    | Unquotesplicing AlexPosn
     	    | Exp_quote AlexPosn
     	    | Exp_lambda AlexPosn
	    | Exp_if AlexPosn
	    | Exp_set AlexPosn
	    | Exp_begin AlexPosn
	    | Exp_cond AlexPosn
	    | Exp_and AlexPosn
	    | Exp_or AlexPosn
	    | Exp_case AlexPosn
	    | Let AlexPosn
	    | Letstar AlexPosn
	    | Letrec AlexPosn
	    | Do AlexPosn
	    | Delay AlexPosn
	    | Quasiquote AlexPosn
	    | Id AlexPosn [Char]
	    | String AlexPosn [Char]
	    | Boolean AlexPosn Bool
	    | Character AlexPosn Char
	    | Number AlexPosn Int
	    deriving (Eq,Show)

getToken (Id _ s) = s

slice [] _ _ = []
slice (x:xs) n m | m <= n = []
      	         | n > 0 = slice xs (n - 1) (m - 1)
		 | n == 0 = x: (slice xs 0 (m - 1))
getString s =
    convertStr (slice s 1 ((length s) - 1))
    where
      convertStr [] = []
      convertStr (x:xs) | x == '\\' = (head xs) : convertStr (tail xs)
                        | otherwise = x: convertStr xs
}
