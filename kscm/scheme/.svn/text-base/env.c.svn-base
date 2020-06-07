/* 
 * env.c --- short description
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

#include "env.h"

#include "scheme.h"
#include "salloc.h"
#include "list.h"
#include "symbol.h"
#include "proc.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* make sure that this object can't be reallocate by gc */
Scheme_env_t scheme_global_environment[1];
Scheme_env_t *scheme_current_environment;

#ifdef USE_ENV2
#define scheme_null_environment NULL;
#else
#define scheme_null_environment scheme_null
#endif	/* USE_ENV2 */

/* locals */
DEFUN_LOCAL(scheme_report_environment);
DEFUN_LOCAL(null_environment);
DEFUN_LOCAL(interaction_environment);

#ifndef _KSCM_KERNEL
static Scheme_prim_bind_t env_funcs[] = {
	{ "scheme-report-environment", scheme_report_environment, 1, 1, },
	{ "null-environment", null_environment, 1, 1, },
	{ "interaction-environment", interaction_environment, 0, 0, },
};
#endif	/* _KSCM_KERNEL */

#ifdef USE_ENV2

void scheme_init_env(Scheme_env_t *env)
{
	struct Binding *bindings;

	SCHEME_ENV_REF_CNT(scheme_global_environment) = 1;
	SCHEME_ENV_DEEPTH(scheme_global_environment) =  0;
	SCHEME_ENV_BIND_CNT(scheme_global_environment) = 0;
	SCHEME_ENV_MAX_BIND(scheme_global_environment) = 128;

	SCHEME_SET_ENV_ENCLOSING(scheme_global_environment, env);
	bindings = scheme_alloc(sizeof(struct Binding) * 128);
	SCHEME_SET_ENV_BINDING(scheme_global_environment, bindings);

	/* make the else clause be default for cond form */
	scheme_define_var(scheme_make_symbol("else"), scheme_true,
			  scheme_global_environment);

#ifdef _KSCM_KERNEL
	scheme_register_primitive(
		"scheme-report-environment",
		scheme_report_environment,
		1, 1, scheme_global_environment
		);
	scheme_register_primitive(
		"null-environment",
		null_environment,
		1, 1, scheme_global_environment
		);
	scheme_register_primitive(
		"interaction-environment",
		interaction_environment,
		0, 0, scheme_global_environment
		);
#else
	scheme_register_prims(env_funcs);
#endif	/* _KSCM_KERNEL */
}

Scheme_obj_t *scheme_env_to_obj(Scheme_env_t *env)
{
	Scheme_obj_t *obj;
	obj = scheme_alloc_obj();
	obj->u.env = env;
	SCHEME_SET_TYPE(obj, scheme_env_type);

	return obj;
}

void scheme_destroy_env(Scheme_env_t *env)
{
	if (SCHEME_ENV_REF_CNT(env))
		return;
	scheme_free(SCHEME_ENV_BINDING(env));
	SCHEME_ENV_DEC_REF_CNT(SCHEME_ENV_ENCLOSING(env));
	scheme_free(env);
}

Scheme_obj_t *scheme_lookup_var(Scheme_obj_t *var, Scheme_env_t *env)
{
	int i;
	struct Binding *p;

__traverse_frame:
	p = SCHEME_ENV_BINDING(env);
	for (i = 0; i < SCHEME_ENV_BIND_CNT(env); p++, i++) {
		if (SAME_OBJ(p->var, var))
			return p->val;
	}
	env = SCHEME_ENV_ENCLOSING(env);
	if (env != NULL)	/* simulate tail resursion */
		goto __traverse_frame;

	/* exception: Unbound variable */
	#ifdef DEBUG_MSG
	printf("Unbound variable: 0x%x\n", (unsigned)var);
	#endif
	return scheme_void;
}

Scheme_env_t *scheme_extend_env(Scheme_obj_t *vars, Scheme_obj_t *vals, Scheme_env_t *base_env)
{
	int cnt;
	Scheme_obj_t *p;
	Scheme_env_t *frame;
	struct Binding *b;
	
	for (p = vars, cnt = 0; SCHEME_PAIRP(p); p = SCHEME_CDR(p), cnt++)
		;
	if (SCHEME_SYMBOLP(p))
		cnt++;

	frame = scheme_alloc(sizeof(Scheme_env_t));
	SCHEME_ENV_REF_CNT(frame) = 0;
	SCHEME_ENV_DEEPTH(frame) =  SCHEME_ENV_DEEPTH(base_env) + 1;
	SCHEME_ENV_BIND_CNT(frame) = cnt;
	cnt = ((cnt + BINDING_SLOTS_SIZE - 1) / BINDING_SLOTS_SIZE) * BINDING_SLOTS_SIZE;
	SCHEME_ENV_MAX_BIND(frame) = cnt;

	SCHEME_SET_ENV_ENCLOSING(frame, base_env);
	SCHEME_ENV_INC_REF_CNT(base_env);
	b = scheme_alloc(sizeof(struct Binding) * cnt);
	SCHEME_SET_ENV_BINDING(frame, b);
	while (SCHEME_PAIRP(vars)) {
		b->var = SCHEME_CAR(vars);
		b->val = SCHEME_CAR(vals);
		vars = SCHEME_CDR(vars);
		vals = SCHEME_CDR(vals);
		b++;
	}
	if (SCHEME_SYMBOLP(vars)) {
		b->var = vars;
		b->val = vals;
	}
	
	return frame;
}

Scheme_obj_t *scheme_define_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_env_t *env)
{
	int i;
	struct Binding *slot, *new_blk;

	slot = SCHEME_ENV_BINDING(env);
	for (i = 0; i < SCHEME_ENV_BIND_CNT(env); slot++, i++) {
		if (SAME_OBJ(slot->var, var)) {
			slot->val = val;
			return var;
		}
	}
	if (i == SCHEME_ENV_MAX_BIND(env)) {
		/* alloc new block of slots */
		SCHEME_ENV_MAX_BIND(env) += BINDING_SLOTS_SIZE;
		new_blk = scheme_alloc(sizeof(struct Binding) * SCHEME_ENV_MAX_BIND(env));
		/* copy old data to new space */
		memcpy(new_blk, SCHEME_ENV_BINDING(env), sizeof(struct Binding) * i);
		scheme_free(SCHEME_ENV_BINDING(env)); /* free old space */
		SCHEME_SET_ENV_BINDING(env, new_blk);
		slot = new_blk + i;
	}
	/* add new binding */
	SCHEME_ENV_BIND_CNT(env) += 1;
	slot->var = var;
	slot->val = val;
	
	return var;
}

Scheme_obj_t *scheme_set_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_env_t *env)
{
	int i;
	Scheme_obj_t *v;
	struct Binding *slot;

	slot = SCHEME_ENV_BINDING(env);
	for (i = 0; i < SCHEME_ENV_BIND_CNT(env); slot++, i++) {
		if (SAME_OBJ(slot->var, var)) {
			v = slot->val;
			slot->val = val;
			return v;
		}
	}

	/* exception: unbounded variable */
	return scheme_void;
}

#else  /* does not use ENV2 */

void scheme_init_env(Scheme_obj_t *env)
{
	struct Binding *pairs;
	Scheme_bindings_t *bindings;

	/* initialize a new binding space */
	pairs = scheme_alloc(sizeof(struct Binding) * 128);
	bindings = scheme_alloc(sizeof(Scheme_bindings_t));
	if (pairs == NULL || bindings == NULL) {
		/* 如果这里出错了还有办法补救么？ */
		scheme_free(pairs);
		scheme_free(bindings);
		return ;
	}
	
	bindings->bind_cnt = 0;
	bindings->max_bind = 128;
	bindings->binds = pairs;
	
	SCHEME_SET_TYPE(scheme_global_environment, scheme_env_type);
	SCHEME_SET_ENV_BINDING(
		scheme_global_environment,
		bindings);
	SCHEME_SET_ENV_ENCLOSING(
		scheme_global_environment,
		scheme_null);

	scheme_register_primitive(
		"scheme-report-environment",
		scheme_report_environment,
		1, 1, scheme_global_environment
		);
	scheme_register_primitive(
		"null-environment",
		null_environment,
		1, 1, scheme_global_environment
		);
	scheme_register_primitive(
		"interaction-environment",
		interaction_environment,
		0, 0, scheme_global_environment
		);
}

Scheme_obj_t *scheme_lookup_var(Scheme_obj_t *var, Scheme_env_t *env)
{
	int i;
	struct Binding *pairs;
	Scheme_bindings_t *b;

	while (!SCHEME_NULLP(env)) {
		b = SCHEME_ENV_BINDING(env);
		pairs = b->binds;
		for (i = 0; i < b->bind_cnt; i++, pairs++) {
			if (SAME_OBJ(pairs->var, var))
				return pairs->val;
		}
		env = SCHEME_ENV_ENCLOSING(env);
	}

	/* fail to lookup variable */
	return scheme_void;
}

Scheme_env_t *scheme_extend_env(Scheme_obj_t *vars, Scheme_obj_t *vals, Scheme_obj_t *base_env)
{
	int cnt, max;
	Scheme_obj_t *p;
	Scheme_env_t *frame;
	Scheme_bindings_t *bindings;
	struct Binding *pairs;

	for (p = vars, cnt = 0; SCHEME_PAIRP(p); p = SCHEME_CDR(p), cnt++)
		;
	if (SCHEME_SYMBOLP(p))	/* (define (foo a . argvs) ...) */
		cnt++;

	max = ((cnt + BINDING_SLOTS_SIZE - 1) / BINDING_SLOTS_SIZE)
		* BINDING_SLOTS_SIZE;
	pairs = scheme_alloc(sizeof(struct Binding) * max);
	bindings = scheme_alloc(sizeof(Scheme_bindings_t));
	frame = scheme_alloc_obj();
	if (pairs == NULL || bindings == NULL) {
		scheme_free(pairs);
		scheme_free(bindings);

		return scheme_void;
	}
	bindings->max_bind = max;
	bindings->bind_cnt = cnt;
	bindings->binds = pairs;
	
	while (SCHEME_PAIRP(vars)) {
		pairs->var = SCHEME_CAR(vars);
		pairs->val = SCHEME_CAR(vals);
		vars = SCHEME_CDR(vars);
		vals = SCHEME_CDR(vals);
		pairs++;
	}
	if (SCHEME_SYMBOLP(vars)) {
		pairs->var = vars;
		pairs->val = vals;
	}

	SCHEME_SET_TYPE(frame, scheme_env_type);
	SCHEME_SET_ENV_NAME(frame, scheme_null);
	SCHEME_SET_ENV_ENCLOSING(frame, base_env);
	SCHEME_SET_ENV_BINDING(frame, bindings);

	return frame;
}

Scheme_obj_t *scheme_define_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_obj_t *env)
{
	int i;
	struct Binding *slot, *new_blk;
	Scheme_bindings_t *b = SCHEME_ENV_BINDING(env);
	
	slot = b->binds;
	for (i = 0; i < b->bind_cnt; slot++, i++) {
		if (SAME_OBJ(slot->var, var)) {
			slot->val = val;
			return var;
		}
	}
	if (i == b->max_bind) {
		/* alloc new block of slots */
		b->max_bind += BINDING_SLOTS_SIZE;
		new_blk = scheme_alloc(sizeof(struct Binding) * b->max_bind);
		memcpy(new_blk, b->binds, sizeof(struct Binding) * i);
		scheme_free(b->binds);
		b->binds = new_blk;
		slot = new_blk + i;
	}
	
	/* add new binding */
	b->bind_cnt += 1;
	slot->var = var;
	slot->val = val;
	
	return var;
}

Scheme_obj_t *scheme_set_var(Scheme_obj_t *var, Scheme_obj_t *val, Scheme_obj_t *env)
{
	int i;
	Scheme_obj_t *v;
	struct Binding *slot;

	slot = SCHEME_ENV_BINDING(env)->binds;
	for (i = 0; i < SCHEME_ENV_BINDING(env)->bind_cnt; slot++, i++) {
		if (SAME_OBJ(slot->var, var)) {
			v = slot->val;
			slot->val = val;
			return v;
		}
	}

	/* exception: unbounded variable */
	return scheme_void;
}

#endif	/* USE_ENV2 */

void scheme_register_prims(Scheme_prim_bind_t *funcs)
{
	while (funcs->fun != NULL) {
		scheme_define_var(
			scheme_make_symbol(funcs->name),
			scheme_make_prim_proc(funcs->fun, funcs->mina, funcs->maxa),
			scheme_global_environment);
		funcs++;
	}
}

void scheme_register_primitive(
	const char *name,
	Scheme_local_func_t fun,
	int mina, int maxa,
	Scheme_env_t *env)
{
	/* there should do more check to display a warning when a
	 * later binding shadow the previous binding */
	scheme_define_var(
		scheme_make_symbol(name),
		scheme_make_prim_proc(fun, mina, maxa),
		env);
}

/* locals */
DEFUN_LOCAL(scheme_report_environment)
{
	
	return scheme_env_to_obj(scheme_global_environment);
}

DEFUN_LOCAL(null_environment)
{
	return scheme_env_to_obj(scheme_null_environment);
}

DEFUN_LOCAL(interaction_environment)
{
	return scheme_env_to_obj(scheme_global_environment);
}
