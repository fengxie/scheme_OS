/* 
 * yylex.c --- short description
 * a simple lex tool used to scan scheme tokens
 * 
 * Copyright  (C)  2005  Wizard' Tse <keith@localhost.localdomain>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Wizard' Tse <keith@localhost.localdomain>
 * Maintainer: Wizard' Tse <keith@localhost.localdomain>
 * URL: http://
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 * 
 * Commentary: 
 * 
 * 
 * 
 * Code:
 */

#include "scmyylex.h"

#include <kscm/lispm.h>

#include <stdlib.h>
#include <ctype.h>

lispm_obj G_yylval;
char *G_current_char_p;

static char * __g_yy_input;

void yylex_start(char *input)
{
	__g_yy_input = input;
	G_current_char_p = input;
}

void yylex_restart()
{
	G_current_char_p = __g_yy_input;
}

void yylex_end()
{
	
}

/* return a string without paired string */
static char *__yylex_getstring()
{
	char *str;
	
	return str;
}

int yylex()
{
	int type, sign;
	char c, *pbuf, *p;

	p = pbuf = (char *)kmalloc(sizeof(char) * YYLEX_MAX_IDN_LEN);
	
	while (isspace(*G_current_char_p))
		G_current_char_p++;

	type = YYLEX_EOI; sign = 1;
	while ((c = *G_current_char_p++) != '\0' && !isspace(c)) {
		switch (c) {
		case '(':
			return YYLEX_LEFT_PAREN;
			break;
		case ')':
			return YYLEX_RIGHT_PAREN;
			break;
		case '.':
			return YYLEX_PERIOD;
			break;
		case '\'':
			return YYLEX_QUOTE; /* convert to (quote x) */
			break;
		case '\"':
			type = YYLEX_STRING;
			LISPM_TYPE(G_yylval) = LISPM_STRING;
			LISPM_TAG(G_yylval) = 1;
			LISPM_STRING_PSTR(G_yylval) = __yylex_getstring();
			break;
		case '`':
			return YYLEX_QUASIQUOTE;
			break;
		case '#':
			c = *G_current_char_p++;
			if (c == 't') {
				LISPM_BOOL_LVAL(G_yylval) = LISPM_BOOL_TRUE;
				return YYLEX_BOOL;
			}
			else if (c == 'f') {
				LISPM_BOOL_LVAL(G_yylval) = LISPM_BOOL_FALSE;
				return YYLEX_BOOL;
			}
			else if (c == '\\') {
				LISPM_CHAR_CHAR(G_yylval) =
					LISPM_ASCII_TO_CHAR(*G_current_char_p++);
				return YYLEX_CHAR;
			}
			else if (c == '(')
				/* the caller know how to handle vector */
				return YYLEX_VECTOR_LPAREN;
			else
				; /* syntax error */
			
			break;
		case '-':
			sign = -1;
		case '+':
			*pbuf++ = c;
			c = *G_current_char_p++;
			
			if (isspace(c))
				return YYLEX_SYMBOL;
			type = YYLEX_NUMBER;
			/* drop to default */
		default:	/* may be a idn or number */
			LISPM_NUMBER_INT(G_yylval) = 0;
			
			for (; c != '\0' && !isspace(c); c = *G_current_char_p++) {
				*pbuf++ = c;
				if (type == YYLEX_SYMBOL)
					continue;
				if (isdigit(c)) {
					LISPM_NUMBER_INT(G_yylval) =
						LISPM_NUMBER_INT(G_yylval) * 10 + (c - '0');
				}
				else
					type = YYLEX_SYMBOL;
			}
			if (type == YYLEX_SYMBOL) {
				*pbuf = '\0';
				LISPM_SYMBOL_STR(G_yylval) = p;
				return type;
			}
			else {
				kfree(pbuf);
				LISPM_NUMBER_INT(G_yylval) *= sign;
				return type;
			}
			
			break;
		}
	}

	return type;
}
