/* 
 * sscan.c --- short description
 * 
 * Copyright  (C)  2005  Fung Tse <wikeithtse@gmail.com>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Fung Tse <wikeithtse@gmail.com>
 * Maintainer: Fung Tse <wikeithtse@gmail.com>
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

#include "sscan.h"
#include "port.h"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

static char _lex_scan_buff[SCHEME_MAX_EXPR_LEN];
static Scheme_token_t _lex_token_buff[1024];

/* read only one expressionion from input port
 * for meta type like symbol, number, string, etc.
 * for compound type like list, vector, etc. */
Scheme_token_t *scheme_make_token_seq(Scheme_obj_t *port)
{
	int i = 0, stack, stat, iscomplex, isfloat, finished;
	char c, *s = _lex_scan_buff;

	iscomplex = stack = isfloat = finished = stat = 0;		/* out of word */
	while ((c = scheme_port_get_char(port)) != EOF) {
	__next_loop:
		if (isspace(c)) {
			if (stat == 1) {
				stat = 0; isfloat = 0;
				*s++ = '\0';
				i++;
				if (stack == 0)
					break;
			}
			continue;
		}
		switch (c) {
		case '(':
			_lex_token_buff[i++].type = scheme_left_par_token;
			stat = 0;
			stack++;
			break;
		case ')':
			if (stat == 1) {
				stat = 0;
				*s++ = '\0';
				i++;
			}
			
			_lex_token_buff[i++].type = scheme_right_par_token;
			stack--;
			if (stack == 0)
				finished = 1;
			break;
		case '\"':
			if (stat == 1) {
				stat = 0;
				*s++ = '\0';
				i++;
			}

			_lex_token_buff[i].type = scheme_string_token;
			_lex_token_buff[i++].token = s;
			while (isprint(c = scheme_port_get_char(port))) {
				*s++ = c;
				
				if (c == '\\') {
					if ((c = scheme_port_get_char(port)) == '\"' ||
					    c == '\\')
						*(s - 1) = c;
					else
						*s++ = c;
				}
				else if (c == '\"') {
					*(s - 1) = '\0';
					break;
				}
			}
			break;
		case '#':
			if (stat == 1) { /* in word */
				*s++ = '#';
				break;
			}
			c = scheme_port_get_char(port);
			switch (c) {
			case '(':
				_lex_token_buff[i++].type = scheme_left_sharpar_token;
				stack++;
				break;
			case '\\':
				_lex_token_buff[i].type = scheme_char_token;
				_lex_token_buff[i++].token = s;
				while (isprint(c = scheme_port_get_char(port))) {
					if (isspace(c) || c == EOF)
						break;
					*s++ = c;
				}
				*s++ = '\0';
				break;
			case 'b': /* binary */
				_lex_token_buff[i++].type = scheme_number_2_token;
				break;
			case 'o': /* octal */
				_lex_token_buff[i++].type = scheme_number_8_token;
				break;
			case 'd': /* decimal */
				_lex_token_buff[i++].type = scheme_number_10_token;
				break;
			case 'x': /* hex */
				_lex_token_buff[i++].type = scheme_number_16_token;
				break;
			case 'i': /* inexact */
				_lex_token_buff[i++].type = scheme_number_inexact_token;
				break;
			case 'e': /* exact */
				_lex_token_buff[i++].type = scheme_number_exact_token;
				break;
			}
			break;
		case '\'':
			_lex_token_buff[i++].type = scheme_quote_token;
			break;
		case '`':
			_lex_token_buff[i++].type = scheme_backquote_token;
			break;
		case ',':	/* , & ,@ */
			c = scheme_port_get_char(port);
			if (c == '@')
				_lex_token_buff[i++].type = scheme_comma_at_token;
			else {
				_lex_token_buff[i++].type = scheme_comma_token;
				/* don't drop this character. i think
				 * that a fun which push the char back to
				 * port might be a better solution. */
				goto __next_loop;
			}
			break;
		case '@':
			if (stat == 0) {
				_lex_token_buff[i].type = scheme_symbol_token;
				_lex_token_buff[i].token = s;
				stat = 1;
			}
			break;
		case '.':
			if (stat == 0) {
				_lex_token_buff[i].type = scheme_point_token;
				_lex_token_buff[i].token = s;
				stat = 1;
			}
			else if (isfloat)
				_lex_token_buff[i].type = scheme_symbol_token;
			else if (_lex_token_buff[i].type == scheme_number_token)
				isfloat = 1;
				
			*s++ = '.';
			break;
		default:
			if (isxdigit(c)) { /* only support decimal now
					    * */
				if (stat == 0) {
					stat = 1;
					_lex_token_buff[i].type = scheme_number_token;
					_lex_token_buff[i].token = s;
				}
				else if (_lex_token_buff[i].type == scheme_point_token) {
					_lex_token_buff[i].type = scheme_number_token;
					isfloat = 1;
				}
			}
			else if (isprint(c)) {
				if (stat == 0) {
					stat = 1;
					_lex_token_buff[i].type = scheme_symbol_token;
					_lex_token_buff[i].token = s;
				}
				else if (_lex_token_buff[i].type = scheme_number_token)
					_lex_token_buff[i].type = scheme_symbol_token;
			}
			*s++ = c;
			break;
		}
		if (finished)
			break;
	}
	
	_lex_token_buff[i].type = -1; /* tag for end */

	return _lex_token_buff;
	
}

void scheme_free_token_seq(Scheme_token_t *seq)
{
	
}
