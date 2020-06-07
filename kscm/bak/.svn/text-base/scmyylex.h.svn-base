/* 
 * scmyylex.h --- short description
 * a simple lex tool
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

#ifndef SCMYYLEX_H
#define SCMYYLEX_H

/* tokens for scheme */
enum TOKENS {
	YYLEX_ERROR = -1,
	YYLEX_EOI = 0,		/* End of input */

	YYLEX_LEFT_PAREN,
	YYLEX_RIGHT_PAREN,
	YYLEX_PERIOD,
	YYLEX_QUOTE,		/* ' */
	YYLEX_QUASIQUOTE,       /* ` */
	YYLEX_SHARP,
	YYLEX_VECTOR_LPAREN,	/* #( */

	YYLEX_SYMBOL,
	YYLEX_CHAR,
	YYLEX_STRING,
	YYLEX_NUMBER,
	YYLEX_BOOL,
};

#define YYLEX_MAX_IDN_LEN 64

void yylex_start(char *);
void yylex_restart();
void yylex_end();

int yylex();

#include <kscm/lispm.h>

extern lispm_obj G_yylval;
extern char *G_current_char_p;

#endif
