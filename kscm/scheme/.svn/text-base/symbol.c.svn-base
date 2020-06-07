/* 
 * symbol.c --- short description
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

#include "symbol.h"

#include "scheme.h"
#include "salloc.h"
#include "sstring.h"
#include "hash.h"

#include <stdlib.h>
#include <string.h>

#define SYMBOL_HTABLE_SIZE 1031
struct _Htentry {
	struct _Htentry *next;
	char *str;
	Scheme_obj_t *symbol;
} *_HTable_[SYMBOL_HTABLE_SIZE];

/* locals */
DEFUN_LOCAL(symbol_p);
DEFUN_LOCAL(eq_p);
DEFUN_LOCAL(symbol_to_string);
DEFUN_LOCAL(string_to_symbol);

static int _symbol_eq_p(const char *a, const char *b);
static long _hash_symbol(const char *obj);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t symbol_funcs[] = {
	{ "symbol?", symbol_p, 1, 1, },
	{ "eq?", eq_p, 2, 2, },
	{ "symbol->string", symbol_to_string, 1, 1, },
	{ "string->symbol", string_to_symbol, 1, 1, },
};

void scheme_init_symbol(Scheme_obj_t *env)
{
	int i;

	for (i = 0; i < SYMBOL_HTABLE_SIZE; i++)
		_HTable_[i] = NULL;
	#ifdef _KSCM_KERNEL
	scheme_register_primitive("symbol?", symbol_p, 1, 1, env);
	scheme_register_primitive("eq?", eq_p, 2, 2, env);
	scheme_register_primitive("symbol->string", symbol_to_string, 1, 1, env);
	scheme_register_primitive("string->symbol", string_to_symbol, 1, 1, env);
	#endif	/* _KSCM_KERNEL */
}

Scheme_obj_t *scheme_make_symbol(const char *str)
{
	/* Hummm, regard it will be work fine ok now, before the
	 * hash-table be implemented. */
	long k;
	char *s;
	Scheme_obj_t *sym;
	struct _Htentry *p;

	k = _hash_symbol(str);
	p = _HTable_[k];
	while (p != NULL) {
		if (_symbol_eq_p(p->str, str))
			return p->symbol;
		p = p->next;
	}

	s = (char *)scheme_alloc(strlen(str)*sizeof(char));
	strcpy(s, str);
	sym = scheme_alloc_obj();
	SCHEME_SET_TYPE(sym, scheme_symbol_type);
	SCHEME_SET_SYMBOL(sym, s);
	SCHEME_SET_SYMBOL_KEY(sym, 0);
	p = scheme_alloc(sizeof(struct _Htentry));
	p->str = s;
	p->symbol = sym;
	p->next = _HTable_[k];
	_HTable_[k] = p;

	return sym;
}

/* locals */
DEFUN_LOCAL(symbol_p)
{
	return (SCHEME_SYMBOLP(argv[0]))? scheme_true: scheme_false;
}

DEFUN_LOCAL(eq_p)
{
	return (argv[0] == argv[1])? scheme_true: scheme_false;
}

DEFUN_LOCAL(symbol_to_string)
{
	return scheme_make_string(SCHEME_SYMBOL_VAL(argv[0]));
}

DEFUN_LOCAL(string_to_symbol)
{
	return scheme_make_symbol(SCHEME_STR_VAL(argv[0]));
}

static int _symbol_eq_p(const char *a, const char *b)
{
	while (*a && *b)
		if (*a++ != *b++)
			return 0;
	if (*a == '\0' && *b == '\0')
		return 1;

	return 0;
}

static long _hash_symbol(const char *obj)
{
	int i, h = 0;
	char *s = (char *)obj;
	
	for (i = 0; s[i] != '\0'; i++)
		;
	while (i-- > 0)
		h += (h<< 5) + h + s[i];
	h += (h << 2);

	return ((unsigned long)h >> 1) % HTABLE_SIZE;
}
