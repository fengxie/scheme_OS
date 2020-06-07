/* 
 * numb.c --- short description
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

#include "numb.h"

#include "scheme.h"
#include "salloc.h"
#include "env.h"

#include <stdio.h>

/* locals */
DEFUN_LOCAL(number_p);
DEFUN_LOCAL(complex_p);		/* not implemented */
DEFUN_LOCAL(real_p);
DEFUN_LOCAL(rational_p);
DEFUN_LOCAL(integer_p);
DEFUN_LOCAL(exact_p);
DEFUN_LOCAL(inexact_p);
DEFUN_LOCAL(addition);
DEFUN_LOCAL(subtraction);
DEFUN_LOCAL(divison);
DEFUN_LOCAL(multiplication);
DEFUN_LOCAL(quotient);
DEFUN_LOCAL(remainder_);
DEFUN_LOCAL(modulo);
DEFUN_LOCAL(numerator);
DEFUN_LOCAL(denominator);
DEFUN_LOCAL(floor_);
DEFUN_LOCAL(ceiling);
DEFUN_LOCAL(truncate);
DEFUN_LOCAL(round_);

DEFUN_LOCAL(exp_);
DEFUN_LOCAL(log_);
DEFUN_LOCAL(sin_);
DEFUN_LOCAL(cos_);
DEFUN_LOCAL(tan_);
DEFUN_LOCAL(asin_);
DEFUN_LOCAL(acos_);
DEFUN_LOCAL(atan_);

DEFUN_LOCAL(number_to_string);
DEFUN_LOCAL(string_to_number);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t numb_funcs[] = {
	{ "number?", number_p, 1, 1, },
	/* { "complex?", complex_p, 1, 1, }, */
	{ "real?", real_p, 1, 1, },
	{ "rational?", rational_p, 1, 1, },
	{ "integer?", integer_p, 1, 1, },
	{ "exact?", exact_p, 1, 1, },
	{ "inexact?", inexact_p, 1, 1, },
	{ "+", addition, 0, -1, },
	{ "-", subtraction, 1, -1, },
	{ "*", multiplication, 0, -1, },
	{ "/", divison, 1, -1, },
	{ NULL, NULL, 0, 0, },
};

void scheme_init_number(Scheme_env_t *env)
{
#ifdef _KSCM_KERNEL
	scheme_register_primitive("number?", number_p, 1, 1, env);
	scheme_register_primitive("real?", real_p, 1, 1, env);
	scheme_register_primitive("rational?", rational_p, 1, 1, env);
	scheme_register_primitive("integer?", integer_p, 1, 1, env);
	scheme_register_primitive("exact?", exact_p, 1, 1, env);
	scheme_register_primitive("inexact?", inexact_p, 1, 1, env);
	scheme_register_primitive("+", addition, 0, -1, env);
	scheme_register_primitive("-", subtraction, 0, -1, env);
	scheme_register_primitive("*", multiplication, 0, -1, env);
	scheme_register_primitive("/", divison, 1, -1, env);
#else
	scheme_register_prims(numb_funcs);
#endif	/* _KSCM_KERNEL */
	
}

Scheme_obj_t *scheme_make_integer_numb(int n)
{
	Scheme_obj_t *numb;

	if (SCHEME_VOIDP(numb = scheme_alloc_obj())) {
		/* exception: out of memory */

		return scheme_void;
	}

	SCHEME_SET_TYPE(numb, scheme_integer_type);
	SCHEME_SET_INT(numb, n);

	return numb;
}

Scheme_obj_t *scheme_make_double_numb(double f)
{
	Scheme_obj_t *dbl;

	if (SCHEME_VOIDP(dbl = scheme_alloc_obj())) {
		/* exception: out of memory */

		return scheme_void;
	}
	SCHEME_SET_TYPE(dbl, scheme_double_type);
	SCHEME_SET_INT(dbl, f);

	return dbl;
}

Scheme_int_t _gcd(Scheme_int_t a, Scheme_int_t b)
{
	Scheme_int_t c;

_gcd_recursion:	
	if (a > b) {
		c = b;
		b = a;
		a = c;
	}
	b -= a;
	if (b != 0)
		/* to simulate a tail-recursion */
		goto _gcd_recursion;

	return a;
}

Scheme_obj_t *scheme_make_rational(Scheme_int_t numerator, Scheme_int_t denominator)
{
	Scheme_int_t k;
	Scheme_obj_t *rat;

	rat = scheme_alloc_obj();
	k = _gcd(numerator, denominator);
	rat->u.int_pair.v1 = numerator / k;
	rat->u.int_pair.v2 = denominator / k;
	
	return rat;
}

/* locals */
DEFUN_LOCAL(number_p)
{
	return (SCHEME_TYPE(argv[0]) > scheme_number_type &&
		SCHEME_TYPE(argv[0]) < _scheme_number_type_)?
		scheme_true: scheme_false;
}

DEFUN_LOCAL(real_p)
{
	return SCHEME_DOUBLEP(argv[0])? scheme_true: scheme_false;
}

DEFUN_LOCAL(rational_p)
{
	return SCHEME_RATP(argv[0])? scheme_true: scheme_false;
}

DEFUN_LOCAL(integer_p)
{
	return SCHEME_INTP(argv[0])? scheme_true: scheme_false;
}

DEFUN_LOCAL(exact_p)
{
	return scheme_true;
}

DEFUN_LOCAL(inexact_p)
{
	return scheme_false;
}

/* support +, -, *, /:  a <- a op b*/
#define _BINARY_OP(op, a, b)						\
	do {								\
		if (SAME_TYPE(SCHEME_TYPE(a), SCHEME_TYPE(b)))		\
			switch (SCHEME_TYPE(a)) {			\
			case scheme_integer_type:			\
				SCHEME_INT_VAL(a) = SCHEME_INT_VAL(a)	\
					op SCHEME_INT_VAL(b);		\
				break;					\
			case scheme_double_type:			\
				SCHEME_DBL_VAL(a) = SCHEME_DBL_VAL(b)	\
					op SCHEME_DBL_VAL(a);		\
				break;					\
			default:					\
				break;					\
			}						\
		else if (SCHEME_TYPE(a) < SCHEME_TYPE(b))		\
			;						\
		else if (SCHEME_TYPE(a) > SCHEME_TYPE(b))		\
			;						\
	} while(0)

DEFUN_LOCAL(addition)
{
	Scheme_obj_t *rslt, **p = argv;

	rslt = scheme_alloc_obj();
	SCHEME_SET_TYPE(rslt, scheme_integer_type);
	SCHEME_SET_INT(rslt, 0);
	while (argc-- > 0) {
		_BINARY_OP(+, rslt, *p);
		p++;
	}
	
	return rslt;
}

DEFUN_LOCAL(subtraction)
{
	Scheme_obj_t *rslt, **p = argv;

	rslt = scheme_alloc_obj();
	if (argc == 1) {
		SCHEME_SET_TYPE(rslt, scheme_integer_type);
		SCHEME_SET_INT(rslt, 0);
	}
	else {
		p++; argc--;
		*rslt = *argv[0];
	}

	while (argc-- > 0) {
		_BINARY_OP(-, rslt, *p);
		p++;
	}
	
	return rslt;
}

DEFUN_LOCAL(multiplication)
{
	Scheme_obj_t *rslt, **p = argv;

	rslt = scheme_alloc_obj();
	SCHEME_SET_TYPE(rslt, scheme_integer_type);
	SCHEME_SET_INT(rslt, 1);
	while (argc-- > 0) {
		_BINARY_OP(*, rslt, *p);
		p++;
	}
	
	return rslt;
}

DEFUN_LOCAL(divison)
{
	Scheme_obj_t *rslt, **p = argv;

	rslt = scheme_alloc_obj();
	if (argc == 1) {
		SCHEME_SET_TYPE(rslt, scheme_integer_type);
		SCHEME_SET_INT(rslt, 1);
	}
	else {
		p++; argc--;
		*rslt = *argv[0];
	}

	while (argc-- > 0) {
		_BINARY_OP(/, rslt, *p);
		p++;
	}
	
	return rslt;
}

DEFUN_LOCAL(quotient)
{
	
}

DEFUN_LOCAL(remainder_)
{
	
}

DEFUN_LOCAL(modulo)
{
	
}

DEFUN_LOCAL(numerator)
{
	return scheme_make_integer_numb(SCHEME_INT_PAIR_V1(argv[0]));
}

DEFUN_LOCAL(denominator)
{
	return scheme_make_integer_numb(SCHEME_INT_PAIR_V2(argv[0]));
}

DEFUN_LOCAL(floor_)
{
	
}

DEFUN_LOCAL(ceiling)
{
	
}

DEFUN_LOCAL(truncate)
{
	
}

DEFUN_LOCAL(round_)
{
	
}

DEFUN_LOCAL(exp_)
{
	
}

DEFUN_LOCAL(log_)
{
	
}

DEFUN_LOCAL(sin_)
{
	
}

DEFUN_LOCAL(cos_)
{
	
}

DEFUN_LOCAL(tan_)
{
	
}

DEFUN_LOCAL(asin_)
{
	
}

DEFUN_LOCAL(acos_)
{
	
}

DEFUN_LOCAL(atan_)
{
	
}
