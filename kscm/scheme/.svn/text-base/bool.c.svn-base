/* 
 * bool.c --- short description
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

#include "bool.h"

#include "scheme.h"
#include "salloc.h"
#include "env.h"

/* global_constants */
Scheme_obj_t scheme_true[1];
Scheme_obj_t scheme_false[1];

static Scheme_obj_t *boolean_p(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *true_p(int argc, Scheme_obj_t *argv[]);
static Scheme_obj_t *not(int argc, Scheme_obj_t *argv[]);

#ifndef _KSCM_KERNEL
Scheme_prim_bind_t bool_funcs[] = {
	{ "boolean?", boolean_p, 1, 1, },
	{ "true?", true_p, 1, 1, },
	{ "not", not, 1, 1, },
};
#endif	/* _KSCM_KERNEL */

void scheme_init_bool(Scheme_env_t *env)
{
	SCHEME_SET_TYPE(scheme_true, scheme_bool_type);
	SCHEME_SET_BOOL(scheme_true, scheme_true_val);
	SCHEME_SET_TYPE(scheme_false, scheme_bool_type);
	SCHEME_SET_BOOL(scheme_false, scheme_false_val);
	#ifdef _KSCM_KERNEL
	scheme_register_primitive("boolean?", boolean_p, 1, 1, env);
	scheme_register_primitive("true?", true_p, 1, 1, env);
	scheme_register_primitive("not", not, 1, 1, env);
	#endif	/* _KSCM_KERNEL */
}

static Scheme_obj_t *boolean_p(int argc, Scheme_obj_t *argv[])
{
	/* SCHEME_PAIR_CAR should be replaced by scheme_first_arg */
	return SCHEME_BOOLP(argv[0])?scheme_true:scheme_false;
}

static Scheme_obj_t *true_p(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_FALSEP(argv[0])?scheme_false:scheme_true;
}

static Scheme_obj_t *not(int argc, Scheme_obj_t *argv[])
{
	return SCHEME_FALSEP(argv[0])?scheme_true:scheme_false;
}
