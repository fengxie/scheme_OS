/* 
 * list.c --- short description
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

#include "list.h"

#include "scheme.h"
#include "env.h"
#include "salloc.h"
#include "display.h"

/* globals */
Scheme_obj_t scheme_null[1];

/* locals */
static Scheme_obj_t *cons(int argc, Scheme_obj_t *argv[]); /* ** */
static Scheme_obj_t *car(int argc, Scheme_obj_t *argv[]);  /* ** */
static Scheme_obj_t *cdr(int argc, Scheme_obj_t *argv[]);  /* ** */
static Scheme_obj_t *set_car(int argc, Scheme_obj_t *argv[]); /* ** */
static Scheme_obj_t *set_cdr(int argc, Scheme_obj_t *argv[]); /* ** */
static Scheme_obj_t *caar(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *cadr(int argc, Scheme_obj_t *argv);
/* ... */
static Scheme_obj_t *cdddar(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *cddddr(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *null_p(int argc, Scheme_obj_t *argv[]); /* ** */
static Scheme_obj_t *list_p(int argc, Scheme_obj_t *argv[]); /* ** */
static Scheme_obj_t *list(int argc, Scheme_obj_t *argv[]);   /* ** */
static Scheme_obj_t *length(int argc, Scheme_obj_t *argv[]); /* * */
static Scheme_obj_t *append(int argc, Scheme_obj_t *argv[]); /* * */
static Scheme_obj_t *reverse(int argc, Scheme_obj_t *argv[]); /* * */
static Scheme_obj_t *list_tail(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *list_ref(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *memq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *memv(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *member(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *assq(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *assv(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *assoc(int argc, Scheme_obj_t *argv[]);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t list_funcs[] = {
	{ "cons", cons, 2, 2, },
	{ "car", car, 1, 1, },
	{ "cdr", cdr, 1, 1, },
	{ "set-car!", set_car, 2, 2, },
	{ "set-cdr!", set_cdr, 2, 2, },
	{ "null?", null_p, 1, 1, },
	{ "list?", list_p, 1, 1, },
	{ "list", list, 0, -1, },
	{ "length", length, 1, 1, },
	{ "append", append, 0, -1, },
	{ "reverse", reverse, 1, 1, },
	{ "null", NULL, 0, 0, },
};

void scheme_init_list(Scheme_env_t *env)
{
	SCHEME_SET_TYPE(scheme_null, scheme_null_type);
#ifdef _KSCM_KERNEL
	scheme_register_primitive("cons", cons, 2, 2, env);
	scheme_register_primitive("car", car, 1, 1, env);
	scheme_register_primitive("cdr", cdr, 1, 1, env);
	scheme_register_primitive("set-car!", set_car, 2, 2, env);
	scheme_register_primitive("set-cdr!", set_cdr, 2, 2, env);
	scheme_register_primitive("null?", null_p, 1, 1, env);
	scheme_register_primitive("list?", list_p, 1, 1, env);
	scheme_register_primitive("list", list, 0, -1, env);
	scheme_register_primitive("length", length, 1, 1, env);
	scheme_register_primitive("append", append, 0, -1, env);
	scheme_register_primitive("reverse", reverse, 1, 1, env);
#else
	scheme_register_prims(list_funcs);
#endif	/* _KSCM_KERNEL */
}

Scheme_obj_t *scheme_make_pair(Scheme_obj_t *car, Scheme_obj_t *cdr)
{
	Scheme_obj_t *cons;

	cons = scheme_alloc_obj();
	SCHEME_SET_TYPE(cons, scheme_pair_type);
	SCHEME_SET_CAR(cons, car);
	SCHEME_SET_CDR(cons, cdr);

	return cons;
}

int scheme_list_to_string(char *buf, Scheme_obj_t *list)
{
	char *__des = buf;
	Scheme_obj_t *p, *car;

	*__des++ = '('; p = list;
	while (SCHEME_PAIRP(p)) {
		car = SCHEME_CAR(p);
		if(SCHEME_PAIRP(car))
			__des += scheme_list_to_string(__des, car);
		else
			__des += scheme_obj_to_string(__des, car);

		*__des++ = ' ';
		p = SCHEME_CDR(p);
	}
	if (!SCHEME_NULLP(p)) {
		*__des++ = '.';
		*__des++ = ' ';
		__des += scheme_obj_to_string(__des, p);
		*__des++ = ' ';
	}
	*(__des - 1) = ')';
	*__des = '\0';

	return __des - buf;
}

/* locals */
static Scheme_obj_t *cons(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *s;

	s = scheme_alloc_obj();
	if (SCHEME_VOIDP(s)) {
		/* exception: out of memory */
		return scheme_void;
	}
	SCHEME_SET_TYPE(s, scheme_pair_type);
	SCHEME_SET_CAR(s, argv[0]);
	SCHEME_SET_CDR(s, argv[1]);

	return s;
}

static Scheme_obj_t *car(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_CAR(argv[0]);
}

static Scheme_obj_t *cdr(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_CDR(argv[0]);
}

static Scheme_obj_t *set_car(int argc, Scheme_obj_t *argv[])
{
	SCHEME_SET_CAR(argv[0], argv[1]);
	return scheme_void;
}

static Scheme_obj_t *set_cdr(int argc, Scheme_obj_t *argv[])
{
	SCHEME_SET_CDR(argv[0], argv[1]);
	return scheme_void;
}

static Scheme_obj_t *null_p(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_NULLP(argv[0])? scheme_true: scheme_false;
}

static Scheme_obj_t *list_p(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *t;

	t = argv[0];
	while (SCHEME_PAIRP(t))
		t = SCHEME_CDR(t);
	return SCHEME_NULLP(t)? scheme_true: scheme_false;
}

static Scheme_obj_t *list(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *l, *p, *q;

	q = l = scheme_null;
	while (argc > 0) {
		p = scheme_alloc_obj();
		if (SCHEME_VOIDP(p)) {
			/* exception: out of memory */
			/* ... */
			
			/* It's ok to set the ``cdr'' of null object
			 * to null safely. q == null indeicate that
			 * the result list is already null, otherwise,
			 * the ``cdr'' of the last cell will be set to
			 * null and the next code will free all the
			 * objects allocated in this operation. */
			SCHEME_SET_CDR(q, scheme_null);
			while (!SCHEME_NULLP(l)) {
				p = l;
				l = SCHEME_CDR(l);
				scheme_free_obj(p);
			}
			
			return scheme_void;
		}
		if (SCHEME_NULLP(l))
			l = p;
		else
			SCHEME_SET_CDR(q, p);
		SCHEME_SET_TYPE(p, scheme_pair_type);
		SCHEME_SET_CAR(p, *argv++);
		
		q = p;
		argc--;
	}

	return l;
}

static Scheme_obj_t *length(int argc, Scheme_obj_t *argv[])
{
	int len;
	Scheme_obj_t *l, *p;

	p = argv[0]; len = 0;
	for (len = 0, p = argv[0]; SCHEME_PAIRP(p); len++, p = SCHEME_CDR(p))
		;
	if (!SCHEME_NULLP(p)) {
		/* exception: wrong type */
		/* ... */
		
		return scheme_void;
	}
	
	l = scheme_alloc_obj();
	if (SCHEME_VOIDP(l)) {
		/* exception: out of memory */
		/* ... */

		return scheme_void;
	}

	SCHEME_SET_TYPE(l, scheme_integer_type);
	SCHEME_SET_INT(l, len);

	return l;
}

/* I'm not sure that this function can work correctly. It should be
 * debuged carefully in future work */
static Scheme_obj_t *append(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *l, *p, *q, *s;

	q = l = scheme_null;
	for (q = l = scheme_null, s = argv[0]; argc > 1; q = p) {
		if (!SCHEME_PAIRP(s)) {
			if (SCHEME_NULLP(s)) {
				argc--;
				s = *argv++;
				if (argc <= 1) {
					p = s;
					goto _append_last_list;
				}
			}
			else {
				/* exception: wrong type */
				/* ... */
		
				return scheme_void;
			}
		}

		p = scheme_alloc_obj();
		if (SCHEME_VOIDP(p)) {
			/* exception: out of memory */
			/* ... */
			
			/* It's ok to set the ``cdr'' of null object
			 * to null safely. q == null indeicate that
			 * the result list is already null, otherwise,
			 * the ``cdr'' of the last cell will be set to
			 * null and the next code will free all the
			 * objects allocated in this operation. */
			SCHEME_SET_CDR(q, scheme_null);
			while (!SCHEME_NULLP(l)) {
				p = l;
				l = SCHEME_CDR(l);
				scheme_free_obj(p);
			}
			
			return scheme_void;
		}
		*p = *s;
		s = SCHEME_CDR(s);

	_append_last_list:
		if (SCHEME_NULLP(l))
			l = p;
		else
			SCHEME_SET_CDR(q, p);
	}
	
	return l;
}

static Scheme_obj_t *reverse(int argc, Scheme_obj_t *argv[])
{
	Scheme_obj_t *l;

	return l;
}
