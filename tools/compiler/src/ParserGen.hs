-- ParserGen.hs --- short description

-- Copyright  (C)  2006  Fung Tse <wikeithtse@gmail.com>

-- Version: 1.0
-- Keywords: 
-- Author: Fung Tse <wikeithtse@gmail.com>
-- Maintainer: Fung Tse <wikeithtse@gmail.com>
-- URL: http://

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-- 02111-1307, USA.

-- Commentary: 

-- General scheme parser definitions

-- Code:

-- FIXME: only export the necessary interfaces
module ParserGen where

import qualified SCM_Lex as L
import Scheme

import Data.Map

import qualified Text.ParserCombinators.Parsec as P
import qualified Text.ParserCombinators.Parsec.Pos as Ppos
import qualified Text.ParserCombinators.Parsec.Error as Perr

import Language.Haskell.TH

-- Top parser definition
type Parser a = P.GenParser L.Token PState a

data PState = PState {
                      -- parsers generated by processing the `define-syntax' block
                      parsers :: Map Identifier (Parser Sentence),
                      -- some local data used by parser
                      -- TODO: support ellipsis is not such easy...
                      macroArgBindings :: Map PatternId MacroArg
                     }

initParserState = PState {
                          parsers = empty,
                          macroArgBindings = empty
                         }

addSyntaxDef :: (Identifier, Parser Sentence) -> PState -> PState
addSyntaxDef (id, parser) pstate = pstate {
                                           parsers = insert id parser (parsers pstate)
                                          }

resetMacroBinding :: PState -> PState
resetMacroBinding ps = ps {
                           macroArgBindings = empty
                          }

hasMacroArg :: PatternId -> PState -> Bool
hasMacroArg patId = (member patId) . macroArgBindings

addMacroArg :: PatternId -> Expr -> PState -> PState
addMacroArg patId exp ps = ps {
                               macroArgBindings = insert patId [exp] (macroArgBindings ps)
                              }

-- for b ... -> 1 2 3 4, b should be bound with (1 2 3 4)
addMacroArg2 :: PatternId -> Expr -> PState -> PState
addMacroArg2 patId exp ps = ps {
                                macroArgBindings = adjust (exp:) patId (macroArgBindings ps)
                               }
                               

getMacroBindingM :: Parser (Map PatternId MacroArg)
getMacroBindingM = do
  ps <- P.getState
  return $ macroArgBindings ps

resetMacroBindingM :: Parser ()
resetMacroBindingM = do
  P.updateState resetMacroBinding

token :: (L.Token -> Maybe a) -> Parser a
token test = P.token showToken posToken testToken
    where
      showToken = show
      posToken tok = getPos (L.getPos tok)
          where
            getPos (_, line, column) = Ppos.newPos "" line column
      testToken tok = test tok

tokenParserGen :: String -> ExpQ
tokenParserGen tok = appE [| token |] $ infixApp lam [| (.) |] [| L.tokenType |]
    where
      lam = lamE [varP $ mkName "t"] $
            caseE (varE $ mkName "t")
                      [
                       match (conP (mkName $ "L." ++ tok) [])
                                 (normalB [| Just () |])
                                 [],
                       match wildP (normalB [| Nothing |]) []
                      ]

-- idParserGen :: String -> ExpQ
-- idParserGen tok = appE [| token |] $ infixApp lam [| (.) |] [| L.tokenType |]
--     where
--       lam = lamE [varP $ mkName "t"] $
--             caseE (varE $ mkName "t")
--                       [
--                        match (conP (mkName $ "L." ++ tok) [])
--                                  (normalB [| Just () |])
--                                  [],
--                        match wildP (normalB [| Nothing |]) []
--                       ]