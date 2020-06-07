/* 
 * syylex.h --- short description
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

#ifndef SYYLEX_H
#define SYYLEX_H

typedef enum Scheme_token_type {
	scheme_null_token,	/* error */
	scheme_eof_token,
	
	_scheme_basic_token_type_, /* 2 */
	scheme_left_par_token,	   /* ( */
	scheme_right_par_token,	   /* ) */
	scheme_left_sharpar_token, /* #( */
	scheme_quote_token,	   /* ' */
	scheme_backquote_token,		/* ` */
	scheme_comma_token,
	scheme_comma_at_token,
	scheme_at_token,
	scheme_point_token,	/* . */
	scheme_delimiter_token,
	scheme_whitespace_token,
	scheme_comment_token,
	scheme_atmosphere_token,
	scheme_letter_token,

	scheme_symbol_token,	/* 17 */
	scheme_boolean_token,	/* #t | #f */
	scheme_true_token,
	scheme_false_token,
	scheme_number_token,
	scheme_complex_token,
	scheme_char_token,	/* #\c */
	scheme_string_token,	/* "xxx" */

	scheme_number_2_token,	/* binary */
	scheme_number_8_token,	/* octal */
	scheme_number_10_token,	/* decimal */
	scheme_number_16_token, /* hex */

	scheme_number_inexact_token,
	scheme_number_exact_token,
} Scheme_token_type_t;

#endif
