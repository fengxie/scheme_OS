/* 
 * env.h --- short description
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

#ifndef ENV_H
#define ENV_H

#include "scheme.h"

#define NULL_ENV ((Scheme_env_t *)NULL)

#define BINDING_SLOTS_SIZE 32

void scheme_init_env(Scheme_env_t *env);
#ifdef USE_ENV2
Scheme_obj_t *scheme_env_to_obj(Scheme_env_t *env);
void scheme_destroy_env(Scheme_env_t *env);
#else  /* USE_ENV2 */
#define scheme_env_to_obj(env) (env)
#define scheme_destroy_env(env)
#endif	/* USE_ENV2 */
Scheme_obj_t *scheme_lookup_var(Scheme_obj_t *var, Scheme_env_t *env);
Scheme_env_t *scheme_extend_env(Scheme_obj_t *vars, Scheme_obj_t *vals, Scheme_env_t *base_env);
Scheme_obj_t *scheme_define_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_env_t *env);
Scheme_obj_t *scheme_set_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_env_t *env);

/* this function can not be used in kernel because the ``ld'' remove
 * all local symbols from the final object file to get a small kernel */
void scheme_register_prims(Scheme_prim_bind_t *funcs);
void scheme_register_primitive(
	const char *name,
	Scheme_local_func_t fun,
	int mina, int maxa,
	Scheme_env_t *env);

extern Scheme_env_t scheme_global_environment[1];
extern Scheme_env_t *scheme_current_environment;

#endif
