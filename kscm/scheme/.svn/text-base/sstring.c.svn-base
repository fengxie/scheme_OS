/* 
 * string.c --- short description
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

#include "sstring.h"

#include "scheme.h"
#include "env.h"
#include "salloc.h"

#include <stdlib.h>
#include <string.h>

static Scheme_obj_t *make_string(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_p(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_length(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ref(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_set(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ci_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_lt(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_gt(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_lt_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_gt_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ci_lt(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ci_gt(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ci_lt_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_ci_gt_eq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *substring(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_append(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_to_list(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *list_to_string(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_copy(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *string_fill(int argc, Scheme_obj_t *argv[]);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t string_funcs[] = {
	{ "make-string", make_string, 1, 2, },
	{ "string", string, 1, -1, },
	{ "string?", string_p, 1, 1, },
	{ "string-length", string_length, 1, 1, },
	{ "string-ref", string_ref, 2, 2, },
	{ "string-set!", string_set, 3, 3, },
	{ "string=?", string_eq, 2, 2, },
	{ "string-ci=?", string_ci_eq, 2, 2, },
	{ "string<?", string_lt, 2, 2, },
	{ "string>?", string_gt, 2, 2, },
	{ "string<=?", string_lt_eq, 2, 2, },
	{ "string>=?", string_gt_eq, 2, 2, },
	{ "string-ci<?", string_ci_lt, 2, 2, },
	{ "string-ci>?", string_ci_gt, 2, 2, },
	{ "string-ci<=?", string_ci_lt_eq, 2, 2, },
	{ "string-ci>=?", string_ci_gt_eq, 2, 2, },
	{ "substring", substring, 3, 3, },
	{ "string-append", string_append, 1, -1, },
	{ "string->list", string_to_list, 1, 1, },
	{ "list->string", list_to_string, 1, 1, },
	{ "string-copy", string_copy, 1, 1, },
	{ "string-fill", string_fill, 2, 2, },
	{ "null", NULL, 0, 0, },
};

void scheme_init_string(Scheme_env_t *env)
{
#ifdef _KSCM_KERNEL
	scheme_register_primitive("make-string", make_string, 1, 2, env);
	scheme_register_primitive("string", string, 1, -1, env);
	scheme_register_primitive("string?", string_p, 1, 1, env);
	scheme_register_primitive("string-length", string_length, 1, 1, env);
	scheme_register_primitive("string-ref", string_ref, 2, 2, env);
	scheme_register_primitive("string-set!", string_set, 3, 3, env);
	scheme_register_primitive("string=?", string_eq, 2, 2, env);
	scheme_register_primitive("string-ci=?", string_ci_eq, 2, 2, env);
	scheme_register_primitive("string<?", string_lt, 2, 2, env);
	scheme_register_primitive("string>?", string_gt, 2, 2, env);
	scheme_register_primitive("string<=?", string_lt_eq, 2, 2, env);
	scheme_register_primitive("string>=?", string_gt_eq, 2, 2, env);
	scheme_register_primitive("string-ci<?", string_ci_lt, 2, 2, env);
	scheme_register_primitive("string-ci>?", string_ci_gt, 2, 2, env);
	scheme_register_primitive("string-ci<=?", string_ci_lt_eq, 2, 2, env);
	scheme_register_primitive("string-ci>=?", string_ci_gt_eq, 2, 2, env);
	scheme_register_primitive("substring", substring, 3, 3, env);
	scheme_register_primitive("string-append", string_append, 1, -1, env);
	scheme_register_primitive("string->list", string_to_list, 1, 1, env);
	scheme_register_primitive("list->string", list_to_string, 1, 1, env);
	scheme_register_primitive("string-copyt", string_copy, 1, 1, env);
	scheme_register_primitive("string-fill", string_fill, 2, 2, env);
#else
	scheme_register_prims(string_funcs);
#endif	/* _KSCM_KERNEL */
}

Scheme_obj_t *scheme_make_string(const char *chars)
{
	int len = strlen(chars);
	char *s;
	Scheme_obj_t *str;
	
	str = scheme_alloc_obj();
	s = scheme_alloc((len + 1) * sizeof(char));
	strcpy(s, chars);
	SCHEME_SET_TYPE(str, scheme_string_type);
	SCHEME_SET_STR(str, s);
	SCHEME_SET_STR_LEN(str, len);

	return str;
}

Scheme_obj_t *scheme_alloc_string(int size, char fill)
{
	char *s;
	Scheme_obj_t *str;

	str = scheme_alloc_obj();
	s = scheme_alloc((size + 1) * sizeof(char));
	SCHEME_SET_TYPE(str, scheme_string_type);
	SCHEME_SET_STR(str, s);
	SCHEME_SET_STR_LEN(str, size);

	return str;
}

/* locals */
static Scheme_obj_t *make_string(int argc, Scheme_obj_t *argv[])
{
	int k;
	char fill, *str;
	Scheme_obj_t *str_obj;

	if (!SCHEME_INTP(argv[0])) {
		/* raise exception */
		return scheme_void;
	}
	/* assume that the number of argument have been checked */
	if (argc == 1)
		fill = 'a';
	else if (SCHEME_CHARP(argv[1]))
		fill = SCHEME_CHAR_VAL(argv[1]);
	else {
		/* exception: wrong type */
		return scheme_void;
	}

	str_obj = scheme_alloc_obj();
	k = SCHEME_INT_VAL(argv[0]);
	
	str = (char *)scheme_alloc(k + 1);
	if (str_obj == NULL || str == NULL) {
		free(str_obj);
		free(str);
		/* exception: out of memory */
		return scheme_void;
	}
	memset(str, fill, k);
	str[k] = '\0';
	SCHEME_SET_TYPE(str_obj, scheme_string_type);
	SCHEME_SET_STR(str_obj, str);
	SCHEME_SET_STR_LEN(str_obj, k);
	
	return str_obj;
}

static Scheme_obj_t *string(int argc, Scheme_obj_t *argv[])
{
	char *str;
	Scheme_obj_t *str_obj;
	
	str_obj = scheme_alloc_obj();
	str = (char *)scheme_alloc(argc + 1);
	if (str_obj == NULL || str == NULL) {
		scheme_free_obj(str_obj);
		scheme_free(str);
		
		/* exception: out of memory */
		return scheme_void;
	}
	SCHEME_SET_TYPE(str_obj, scheme_string_type);
	SCHEME_SET_STR(str_obj, str);
	SCHEME_SET_STR_LEN(str_obj, argc);
	
	while (argc > 0) {
		if (!SCHEME_CHARP(argv[0])) {
			scheme_free_obj(str_obj);
			scheme_free(str);

			/* exception: wrong type of argument */
			return scheme_void;
		}
		*str++ = SCHEME_CHAR_VAL(*argv++);
		argc--;
	}
	*str = '\0';

	return str_obj;
}

static Scheme_obj_t *string_p(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_STRINGP(argv[0])?scheme_true:scheme_false;
}

static Scheme_obj_t *string_length(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *int_obj;
	
	int_obj = scheme_alloc_obj();
	if (int_obj == NULL) {
		/* exception: out of memory */
		return scheme_void;
	}
	SCHEME_SET_INT(int_obj, SCHEME_STR_LEN(argv[0]));

	return int_obj;
}

static Scheme_obj_t *string_ref(int argc, Scheme_obj_t *argv[])
{
	int idx;
	char c;

	if ((idx = SCHEME_INT_VAL(argv[1])) < SCHEME_STR_LEN(argv[0]))
		c = SCHEME_STR_VAL(argv[0])[idx];
	else {
		/* exception: index not in correct range */
		return scheme_void;
	}

	return SCHEME_CHAR_TO_OBJ(c);
}

static Scheme_obj_t *string_set(int argc, Scheme_obj_t *argv[])
{
	int idx;

	if ((idx = SCHEME_INT_VAL(argv[1])) < SCHEME_STR_LEN(argv[0]))
		SCHEME_STR_VAL(argv[0])[idx] = SCHEME_CHAR_VAL(argv[2]);
	else {
		/* exception: index not in correct range */
		return scheme_void;
	}

	return scheme_void;	/* what is undefined value?? */
}

static Scheme_obj_t *string_eq(int argc, Scheme_obj_t *argv[])
{
	return strcmp(SCHEME_STR_VAL(argv[0]), SCHEME_STR_VAL(argv[1]))?
		scheme_false:
		scheme_true;
}

static Scheme_obj_t *string_ci_eq(int argc, Scheme_obj_t *argv[])
{
	return strcasecmp(SCHEME_STR_VAL(argv[0]), SCHEME_STR_VAL(argv[1]))?
		scheme_false:
		scheme_true;
}

static Scheme_obj_t *string_lt(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_gt(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_lt_eq(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_gt_eq(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_ci_lt(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_ci_gt(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_ci_lt_eq(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_ci_gt_eq(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *substring(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_append(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_to_list(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *list_to_string(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}

static Scheme_obj_t *string_copy(int argc, Scheme_obj_t *argv[])
{
	char *str;
	Scheme_obj_t *str_obj;

	if (!SCHEME_STRINGP(argv[0])) {
		/* raise exception */
		return scheme_void;
	}

	str_obj = scheme_alloc_obj();
	str = (char *)scheme_alloc(SCHEME_STR_LEN(argv[0]));
	if (str_obj == NULL || str == NULL) {
		scheme_free_obj(str_obj);
		scheme_free(str);
		/* exception: out of memory */
		return scheme_void;
	}
	memcpy(str, SCHEME_STR_VAL(argv[0]), SCHEME_STR_LEN(argv[0]));
	SCHEME_SET_STR_LEN(str_obj, SCHEME_STR_LEN(argv[0]));

	return str_obj;
}

static Scheme_obj_t *string_fill(int argc, Scheme_obj_t *argv[])
{
	return scheme_void;
}
