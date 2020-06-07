{
module SCM_Lex (TokenType(..),
                Token,
                scanTokens,
                isPrimData,
                isSymbol,
                tokenType,
                getPos, 
                getDatum) where

import Char (toLower)
import Scheme (Datum(..), Sym(..))
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
       $leftpar			{ \p _ -> Tok Leftpar p Void }
       $rightpar		{ \p _ -> Tok Rightpar p Void }
       @leftsharpar		{ \p _ -> Tok Leftsharpar p Void }
       $point                   { \p _ -> Tok Point p Void }
       $quote			{ \p _ -> Tok Quote p Void }
       -- syntactic keywords
       "else"			{ \p _ -> Tok Else p Void }
       "=>"			{ \p _ -> Tok Rightarrow p Void }
       "define"			{ \p _ -> Tok Define p Void }
       "define-syntax"		{ \p _ -> Tok DefineSyntax p Void }
       "syntax-rules"		{ \p _ -> Tok SyntaxRules p Void }
       "`"                      { \p _ -> Tok Quasiquote p Void }
       "quasiquote"		{ \p _ -> Tok Quasiquote p Void }
       "unquote"		{ \p _ -> Tok Unquote p Void }
       ","			{ \p _ -> Tok Unquote p Void }
       "unquote-splicing"	{ \p _ -> Tok Unquotesplicing p Void }
       ",@"			{ \p _ -> Tok Unquotesplicing p Void }
       -- Expression keywordsnn
       "quote"			{ \p _ -> Tok Exp_quote p Void }
       "lambda"		 	{ \p _ -> Tok Exp_lambda p Void }
       "if"		 	{ \p _ -> Tok Exp_if p Void }
       "set!"		 	{ \p _ -> Tok Exp_set p Void }
       "begin"		 	{ \p _ -> Tok Exp_begin p Void }
       "cond"		 	{ \p _ -> Tok Exp_cond p Void }
       "and"		 	{ \p _ -> Tok Exp_and p Void }
       "or"		 	{ \p _ -> Tok Exp_or p Void }
       "case"		 	{ \p _ -> Tok Exp_case p Void }
       "let"		 	{ \p _ -> Tok Let p Void }
       "let*"		 	{ \p _ -> Tok Letstar p Void }
       "letrec"		 	{ \p _ -> Tok Letrec p Void }
       "do"		 	{ \p _ -> Tok Do p Void }
       "delay"		 	{ \p _ -> Tok Delay p Void }
       @identifier		{ \p -> (Tok PrimData p) . Symbol . Sym . (map toLower) }
       @true			{ \p _ -> Tok PrimData p (Boolean True) }
       @false			{ \p _ -> Tok PrimData p (Boolean False) }
       @char			{ \p s -> Tok PrimData p $ Character $
				                            case s of
					                       "#\\space" -> ' '
					                       "#\\newline" -> '\n'
					                       _ -> (head . tail . tail) s }
       @string			{ \p -> (Tok PrimData p) . String . getString }
       @sign @uinteger10	{ \p -> (Tok PrimData p) . Number . read }


{
data TokenType = Leftpar 
               | Rightpar 
	       | Leftsharpar 
	       | Quote 
               | Point 
	       | Else 
	       | Rightarrow 
	       | Define
	       | DefineSyntax
               | SyntaxRules
	       | Unquote 
	       | Unquotesplicing 
     	       | Exp_quote 
     	       | Exp_lambda 
	       | Exp_if 
	       | Exp_set 
	       | Exp_begin 
	       | Exp_cond 
	       | Exp_and 
	       | Exp_or 
	       | Exp_case 
	       | Let 
	       | Letstar 
	       | Letrec 
	       | Do 
	       | Delay 
	       | Quasiquote 
	       | PrimData
               deriving (Eq,Show)
               
data Token = Tok {
                  tok :: TokenType,
                  pos :: AlexPosn,
                  datum :: Datum
                 }
                 deriving (Eq,Show)

isPrimData t = if (tokenType t) == PrimData
               then True
	       else False

isSymbol tok = case (getDatum tok) of
                 Symbol _ -> True
		 _ -> False

alexPos2tuple (AlexPn cnt ln col) = (cnt, ln, col)

tokenType :: Token -> TokenType
tokenType = tok

getPos :: Token -> (Int, Int, Int)
getPos = alexPos2tuple . pos

getDatum :: Token -> Datum
getDatum = datum

getString = tail . init

scanTokens = alexScanTokens
}
