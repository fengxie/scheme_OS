/* 
 * read.c --- short description
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

#include "read.h"

#include "scheme.h"
#include "env.h"
#include "salloc.h"
#include "list.h"
#include "port.h"
#include "syylex.h"
#include "symbol.h"
#include "numb.h"
#include "sstring.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define TEST

DEFUN_LOCAL(read);
DEFUN_LOCAL(read_char);
DEFUN_LOCAL(peek_char);
DEFUN_LOCAL(eof_object_p);
DEFUN_LOCAL(char_ready_p);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t read_funcs[] = {
	{ "read", read, 0, 1, },
	{ "read-char", read_char, 0, 1, },
	{ "peek-char", peek_char, 0, 1, },
	{ "eof-object?", eof_object_p, 1, 1, },
	{ "char-ready?", char_ready_p, 0, 1, },
};
	
#define SCHEME_MAX_EXPR_LEN (64 * 1024)
typedef struct {
	Scheme_token_type_t type;
	char *token;
} Scheme_token_t;

static char _lex_scan_buff[SCHEME_MAX_EXPR_LEN];
static Scheme_token_t _lex_token_buff[1024];
static int _lex_errno;

void scheme_init_read(Scheme_env_t *env)
{
	_lex_errno = 0;		/* no error */

	#ifdef _KSCM_KERNEL
	scheme_register_primitive("read", read, 0, 1, env);
	scheme_register_primitive("read-char", read_char, 0, 1, env);
	scheme_register_primitive("peek-char", peek_char, 0, 1, env);
	scheme_register_primitive("eof-object?", eof_object_p, 1, 1, env);
	scheme_register_primitive("char-ready?", char_ready_p, 0, 1, env);
	#else
	scheme_register_prims(read_funcs);
	#endif	/* _KSCM_KERNEL */
}

Scheme_obj_t *scheme_read(Scheme_obj_t *port)
{
	if (SCHEME_NULLP(port))
		return read(0, &port);
	return read(1, &port);
}

/* locals */
static Scheme_token_t *_make_token_seq(Scheme_obj_t *port);
static void _free_token_seq(Scheme_token_t *seq);

static Scheme_obj_t *_token_to_obj(const Scheme_token_t *token);
static Scheme_obj_t *_create_list(Scheme_token_t **token_list);
static Scheme_obj_t *_create_vector(Scheme_token_t **token_list);
static Scheme_obj_t *_create_quoted(Scheme_token_t **token_list);

DEFUN_LOCAL(read)
{
	Scheme_obj_t *port, *form;
	Scheme_token_t *token_list;

	if (argc == 0)
		port = scheme_current_input_port;
	else
		port = *argv;

	token_list = _make_token_seq(port);
		
	form = scheme_null;
	switch (token_list->type) {
	case scheme_left_par_token: /* list or pair */
		token_list++;
		form = _create_list(&token_list);
		break;
	case scheme_right_par_token: /* exception: illegal form */
		return scheme_void;
		break;
	case scheme_left_sharpar_token:
		token_list++;
		form = _create_vector(&token_list);
		break;
	case scheme_quote_token:
		token_list++;
		form = _create_quoted(&token_list);
		break;
	default:		/* meta-type */
		form = _token_to_obj(token_list);
		break;
	}

	_free_token_seq(token_list);

	return form;
}

DEFUN_LOCAL(read_char)
{
	return SCHEME_CHAR_TO_OBJ(scheme_port_get_char(argv[0]));
}

DEFUN_LOCAL(peek_char)
{
	return SCHEME_CHAR_TO_OBJ(scheme_port_peek_char(argv[0]));
}

DEFUN_LOCAL(eof_object_p)
{
	return scheme_port_peek_char(argv[0]) == EOF? scheme_true: scheme_false;
}

DEFUN_LOCAL(char_ready_p)
{
	return scheme_true;
}

/* only for some meta type of objects */
static Scheme_obj_t *_token_to_obj(const Scheme_token_t *token)
{
	Scheme_obj_t *obj = scheme_null;

	switch (token->type) {
	case scheme_symbol_token:
		obj = scheme_make_symbol(token->token);
		break;
	case scheme_true_token:
		obj = scheme_true;
		break;
	case scheme_false_token:
		obj = scheme_false;
		break;
	case scheme_number_token:
		obj = scheme_make_integer_numb(atoi(token->token));
		break;
	case scheme_char_token:
		obj = SCHEME_CHAR_TO_OBJ(*(token->token));
		break;
	case scheme_string_token:
		obj = scheme_make_string(token->token);
		break;
	default:		/* unknown type */
		obj = scheme_void;
		break;
	}

	return obj;
}

static Scheme_obj_t *_create_list(Scheme_token_t **token_list)
{
	int issexp = 0;
	Scheme_obj_t *l, *p, *q, *car;

	q = l = scheme_null;
	while ((*token_list)->type != -1 &&
	       (*token_list)->type != scheme_right_par_token) {
		switch ((*token_list)->type) {
		case scheme_left_par_token:
			(*token_list)++;
			car = _create_list(token_list);
			break;
		case scheme_left_sharpar_token:
			(*token_list)++;
			car = _create_vector(token_list);
			break;
		case scheme_quote_token:
			(*token_list)++;
			car = _create_quoted(token_list);
			break;
		case scheme_point_token:
			(*token_list)++;
			if (issexp) {
				/* exception: wrong form */
				return scheme_void;
			}
			issexp = 1;
			continue;
			break;
		default:
			car = _token_to_obj(*token_list);
			(*token_list)++;
			break;
		}
		if (issexp == 0)
			p = scheme_make_pair(car, scheme_null);
		else if (l == scheme_null) { /* exception: illegal form */
			return scheme_void;
		}
		else
			p = car;
		if (l == scheme_null)
			l = p;
		else if (SCHEME_PAIRP(q))
			SCHEME_SET_CDR(q, p);
		else {
			/* exception: illegal form */
			return scheme_void;
		}
		q = p;
	}
	(*token_list)++;
	
	return l;
}

static Scheme_obj_t *_create_vector(Scheme_token_t **token_list)
{
	int len, par;
	Scheme_obj_t *v, **fill;
	Scheme_token_t *t;

	for (len = par = 0, t = *token_list; t->type != -1 && par >= 0; t++) {
		switch (t->type) {
		case scheme_left_par_token:
			par++;
			break;
		case scheme_right_par_token:
			par--;
			if (par == 0)
				len++;
			break;
		case scheme_left_sharpar_token:
			par++;
			break;
		default:
			if (par == 0)
				len++;
			break;
		}
	}

	v = scheme_alloc_obj();
	fill = (Scheme_obj_t **)scheme_alloc(len * sizeof(Scheme_obj_t *));
	SCHEME_SET_TYPE(v, scheme_vector_type);
	SCHEME_SET_VECTOR_BUF(v, fill);
	SCHEME_SET_VECTOR_LEN(v, len);
	while ((*token_list)->type != -1 &&
	       (*token_list)->type != scheme_right_par_token) {
		switch ((*token_list)->type) {
		case scheme_left_par_token:
			(*token_list)++;
			*fill++ = _create_list(token_list);
			break;
		case scheme_left_sharpar_token:
			(*token_list)++;
			*fill++ = _create_vector(token_list);
			break;
		default:
			*fill++ = _token_to_obj(*token_list);
			(*token_list)++;
			break;
		}
	}
	(*token_list)++;
	
	return v;
}

static Scheme_obj_t *_create_quoted(Scheme_token_t **token_list)
{
	Scheme_obj_t *qt, *text;

	switch ((*token_list)->type) {
	case scheme_left_par_token: /* list or pair */
		(*token_list)++;
		text = _create_list(token_list);
		break;
	case scheme_right_par_token: /* exception: illegal form */
		return scheme_void;
		break;
	case scheme_left_sharpar_token:
		(*token_list)++;
		text = _create_vector(token_list);
		break;
	case scheme_quote_token:
		(*token_list)++;
		text = _create_quoted(token_list);
		break;
	default:		/* meta-type */
		text = _token_to_obj(*token_list);
		(*token_list)++;
		break;
	}
	qt = scheme_make_pair(scheme_make_symbol("quote"),
			      scheme_make_pair(text, scheme_null));
	
	return qt;
}

/* read only one expressionion from input port.
 * for meta-type like symbol, number, string, etc.
 * for compound type like list, vector, etc. */
static Scheme_token_t *_make_token_seq(Scheme_obj_t *port)
{
	int i = 0, stack, stat, iscomplex, isfloat, finished;
	char c, *s = _lex_scan_buff;

	iscomplex = stack = isfloat = finished = stat = 0;		/* out of word */
	/* should be fixed: can not analyze such string that contain
	 * more than one lines */
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
			case 't':
				_lex_token_buff[i++].type = scheme_true_token;
				break;
			case 'f':
				_lex_token_buff[i++].type = scheme_false_token;
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
			default: /* illegal form */
				#ifdef DEBUG_MSG
				printf("Illegal form\n");
				#endif	/* DEBUG_MSG */
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
			if (isdigit(c)) { /* only support decimal now
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
				else if (_lex_token_buff[i].type == scheme_number_token)
					_lex_token_buff[i].type = scheme_symbol_token;
			}
			*s++ = c;
			break;
		}
		if (finished)
			break;
	}
	
	if (stat == 1) {
		*s = '\0';
		i++;
	}
	_lex_token_buff[i].type = -1; /* tag for end */

	return _lex_token_buff;
	
}

static void _free_token_seq(Scheme_token_t *seq)
{
	
}
