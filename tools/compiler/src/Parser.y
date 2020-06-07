{
module Parser where

import qualified Scmlex as Lex
import Exptype
}

%name scmParser
%tokentype { Lex.Token }

%token
      '('             { Lex.Leftpar _ }
      ')'             { Lex.Rightpar _ }
      point           { Lex.Point _ }
      else            { Lex.Else _ }
      "=>"            { Lex.Rightarrow _ }
      define          { Lex.Define _ }
      lambda          { Lex.Exp_lambda _ }
      if              { Lex.Exp_if _ }
      set             { Lex.Exp_set _ }
      cond            { Lex.Exp_cond _ }
      case            { Lex.Exp_case _ }
      and             { Lex.Exp_and _ }
      or              { Lex.Exp_or _ }
      let             { Lex.Let _ }
      unquote         { Lex.Unquote _ } 
      unquotesplicing { Lex.Unquotesplicing _ }
      '\''            { Lex.Quote _ }
      quote           { Lex.Exp_quote _ }
      id              { Lex.Id _ $$ }
      string          { Lex.String _ $$ }
      bool            { Lex.Boolean _ $$ }
      char            { Lex.Character _ $$ }
      number          { Lex.Number _ $$ }

-- %right '('
-- %left ')'

%%

Exprs: {- empty -}              { [] }
     | Expr Exprs               { $1 : $2 }
Expr: Expr0                     { $1 }
    | Definition                { $1 }

Expr0: Var                      { Variable $1 }
    | Literal                   { $1 }
    | ProcCall                  { $1 }
    | Lambda                    { $1 }
    | IfExp	                { $1 }
    | Assignment                { $1 }
    | DerivedExpr               { $1 }
Expr0s: {- empty -}             { [] }
      | Expr0 Expr0s            { $1 : $2 }

Literal: Quotation              { $1 }
       | bool                   { SelfEval . Boolean $ $1 }
       | number                 { SelfEval . Number $ $1 }
       | char                   { SelfEval . Character $ $1 }
       | string                 { SelfEval . String $ $1 }

Quotation: '\'' Datum           { Quote $2 }
         | '(' quote Datum ')'  { Quote $3 }

Datum: bool                     { Boolean $1 }
     | number                   { Number $1 }
     | char                     { Character $1 }
     | string                   { String $1 }
     | id                       { Symbol . Sym $ $1 }
     | '(' Datum_star ')'       { List $2 }
     | '(' Datum_star point Datum ')'
                                { SExp $2 $4 }

Datum_star: {- empty -}         { [] }
          | Datum Datum_star    { $1 : $2 }
Datum_plus: Datum               { [$1] }
          | Datum Datum_plus    { $1 : $2 }

ProcCall: '(' Operator Operands ')'
                                { ProcCall $2 $3 }
Operator: Expr0                 { $1 }
-- Operands: Expr0s                { $1 }
Operands:                       { [] }
        | Operands Expr0        { $2 : $1 }

Lambda: '(' lambda Formals Body ')'
                                { Lambda $3 $4 }

Formals: Var                    { Args2 [] $1 }
       | '(' Var_star ')'       { Args $2 }
       | '(' Var_plus point Var ')'
                                { Args2 $2 $4 }

Var_star: {- empty -}           { [] }
        | Var Var_star          { $1 : $2 }
Var_plus: Var                   { [$1] }
        | Var Var_plus          { $1 : $2 }
Var: id                         { Sym $1 }
   
Body:  Exprs                    { Body [] $1 }

Definition: '(' define Var Expr0 ')'
                                { Defvar $3 $4 }
          | '(' define '(' Var Var_star ')' Body ')'
                                { Defun $4 $5 $7 }
          | '(' define '(' Var Var_plus point Var ')' Body ')'
                                { Defun2 $4 $5 $7 $9 }
Definitions: {- empty -}        { [] }
--     | Definition         { [$1] }

IfExp: '(' if Expr0 Expr0 Expr0 ')'
                                { Branch $3 $4 $5 }

Assignment: '(' set Var Expr0 ')'
                                { Assign $3 $4 }

DerivedExpr: '(' cond CondClause_plus ')'
                                { Cond $3 }
           | '(' case Expr0 CaseClause_star ')'
                                { Case $3 $4 [] }
           | '(' and Expr0s ')' { And $3 }
           | '(' or Expr0s ')' { Or $3 }
           | '(' let '(' Bindings ')' Body ')'
                                { Let $4 $6 }


CondClause: '(' Expr0 Expr0 Expr0s ')'         { ($2, $3 : $4) }
          | '(' Expr0 ')'                      { ($2, [] ) }
          | '(' Expr0 "=>" Expr0 ')'           { ($2, [$4]) }
          | ElseClause                         { (SelfEval . Boolean $ True, $1) }

ElseClause: '(' else Expr0 Expr0s ')'           { $3 : $4 }

CondClause_star:                           { [] }
               | CondClause CondClause_star        { $1: $2 }

CondClause_plus: CondClause CondClause_star { $1 : $2 }

CaseClause: '(' '(' Datum_star ')' Expr0 Expr0s ')'
                                                { ($3, $5 : $6) }
          | ElseClause                          { ([Void], $1) }

CaseClause_star:                               { [] }
               | CaseClause CaseClause_star    { $1 : $2 }

Bind: '(' Var Expr0 ')'                        { ($2, $3) }

Bindings:                                      { [] }
        | Bind Bindings                        { $1 : $2 }

{
happyError :: [Lex.Token] -> a
happyError (x: xs) =
    error ("Parser error at " ++ (show x)) 
               
}
