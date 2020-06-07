/* 
 * exp.c --- short description
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

#include "eval.h"

#include "scheme.h"
#include "salloc.h"
#include "list.h"
#include "env.h"
#include "proc.h"

#include <stdio.h>

/* locals */
DEFUN_LOCAL(eval);

#ifndef TEST
static
#endif	/* TEST */
Scheme_prim_bind_t eval_funcs[] = {
	{ "eval", eval, 2, 2, },
};

#define _DEFUN_EVAL_FUN(fn_name, exp, env) static Scheme_obj_t *	\
	fn_name(Scheme_obj_t *exp, Scheme_env_t *env)

_DEFUN_EVAL_FUN(_eval_variable, exp, env);
_DEFUN_EVAL_FUN(_eval_assignment, exp, env);
_DEFUN_EVAL_FUN(_eval_defvar, exp, env);
_DEFUN_EVAL_FUN(_eval_defun, exp, env);
_DEFUN_EVAL_FUN(_eval_if, exp, env);
_DEFUN_EVAL_FUN(_eval_lambda, exp, env);
/* _DEFUN_EVAL_FUN(_eval_begin, exp, env); */
_DEFUN_EVAL_FUN(_eval_cond, exp, env);
_DEFUN_EVAL_FUN(_eval_application, exp, env);
_DEFUN_EVAL_FUN(_eval_and, exp, env);
_DEFUN_EVAL_FUN(_eval_or, exp, env);
_DEFUN_EVAL_FUN(_eval_list, exp, env);

typedef Scheme_obj_t *(*_Eval_fun_t)(Scheme_obj_t *exp, Scheme_env_t *env);
static _Eval_fun_t _eval_funs_[] = {
	NULL,
	NULL,			/* _eval_self_evaluating */
	NULL,			/* _eval_quoted */
	_eval_variable,
	_eval_assignment,
	_eval_defvar,
	_eval_defun,
	_eval_if,
	_eval_lambda,
	scheme_eval_sequence,		/* _eval_begin */
	scheme_eval_sequence,
	_eval_cond,
	_eval_application,
	_eval_and,
	_eval_or,
	NULL,
};

static Scheme_obj_t *_analyze(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_application(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_sequence(Scheme_obj_t *seq);

static Scheme_obj_t *_analyze_and(Scheme_obj_t *seq);
static Scheme_obj_t *_analyze_begin(Scheme_obj_t *seq);
static Scheme_obj_t *_analyze_case(Scheme_obj_t *seq);
static Scheme_obj_t *_analyze_cond(Scheme_obj_t *seq);
static Scheme_obj_t *_analyze_definition(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_delay(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_loop(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_else(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_if(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_lambda(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_let(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_letrec(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_let_star(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_or(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_quasiquote(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_quoted(Scheme_obj_t *obj);
static Scheme_obj_t *_analyze_assignment(Scheme_obj_t *obj);

typedef Scheme_obj_t *(*_Analyze_func_t)(Scheme_obj_t *obj);
struct _Analyze_func {
	char *name;
	_Analyze_func_t fun;
} _analyze_funcs_[] = {
	{ "and", _analyze_and, },
	{ "begin", _analyze_begin, },
	{ "case", _analyze_case, },
	{ "cond", _analyze_cond, },
	{ "define", _analyze_definition, },
	{ "delay", _analyze_delay, },
	{ "do", _analyze_loop, },
	{ "else", _analyze_else, },
	{ "if", _analyze_if, },
	{ "lambda", _analyze_lambda, },
	{ "let", _analyze_let, },
	{ "letrec", _analyze_letrec, },
	{ "let*", _analyze_let_star, },
	{ "or", _analyze_or, },
	{ "quasiquote", _analyze_quasiquote, },
	{ "quote", _analyze_quoted, },
	{ "set!", _analyze_assignment, },
	{ NULL, NULL, },
};
static _Analyze_func_t _find_keyword(char *key);

Scheme_obj_t *scheme_eval(Scheme_obj_t *exp, Scheme_env_t *env)
{
	_Eval_fun_t eval;

	if (SCHEME_NULLP(exp)) {
		return scheme_null;
	}
	exp = _analyze(exp);
	
	if (SAME_TYPE(SCHEME_TYPE(exp), scheme_self_evaluating_type) ||
	    SAME_TYPE(SCHEME_TYPE(exp), scheme_quoted_expr_type))
		return SCHEME_CAR(exp);

	eval = _eval_funs_[SCHEME_TYPE(exp) - _scheme_expr_type_];
	if (eval == NULL) {	/* exception: */
		return scheme_void;
	}

	return eval(exp, env);
}

Scheme_obj_t *scheme_eval_sequence(Scheme_obj_t *exp, Scheme_env_t *env)
{
	if (SCHEME_NULLP(exp))
		return scheme_null;
	
	while (!SCHEME_NULLP(SCHEME_CDR(exp))) {
		scheme_eval(SCHEME_CAR(exp), env);
		exp = SCHEME_CDR(exp);
	}

	return scheme_eval(SCHEME_CAR(exp), env);
}

/* locals */
static Scheme_obj_t *_analyze(Scheme_obj_t *obj)
{
	_Analyze_func_t __analyze_keyword;
	Scheme_obj_t *expr = scheme_void;

	if (SCHEME_TYPE(obj) > _scheme_expr_type_) { /* analyzed expr */
		return obj;
	}

	switch (SCHEME_TYPE(obj)) {
	case scheme_char_type:
	case scheme_number_type:
	case scheme_integer_type:
	case scheme_bignum_type:
	case scheme_rational_type:
	case scheme_real_type:
	case scheme_float_type:
	case scheme_double_type:
	case scheme_string_type:
	case scheme_null_type:
	case scheme_vector_type:
	case scheme_bool_type:
		expr = scheme_alloc_obj();
		SCHEME_SET_TYPE(expr, scheme_self_evaluating_type);
		SCHEME_SET_CAR(expr, obj);
		break;
	case scheme_symbol_type:
		expr = scheme_alloc_obj();
		SCHEME_SET_TYPE(expr, scheme_variable_expr_type);
		SCHEME_SET_CAR(expr, obj);
		break;
	case scheme_pair_type:
		switch (SCHEME_TYPE(SCHEME_CAR(obj))) {
		case scheme_symbol_type:
			__analyze_keyword
				= _find_keyword(SCHEME_SYMBOL_VAL(SCHEME_CAR(obj)));
			if (__analyze_keyword != NULL) {
				expr = __analyze_keyword(obj);
				break;
			}
			/* application expression, drop to the next conditon */
		case scheme_pair_type:
			expr = _analyze_application(obj);
			break;
		default:	/* exception: illegal form */
			break;
		}
		break;
	default:		/* unknown type */
		expr = scheme_void;
		break;
	}

	return expr;
}

DEFUN_LOCAL(eval)
{
	return scheme_eval(argv[0], SCHEME_ENV(argv[1]));
}

_DEFUN_EVAL_FUN(_eval_variable, exp, env)
{
	return scheme_lookup_var(SCHEME_CAR(exp), env);
}

_DEFUN_EVAL_FUN(_eval_assignment, exp, env)
{
	return scheme_set_var(SCHEME_CAR(exp),
			      scheme_eval(SCHEME_CDR(exp), env),
			      env);
}

_DEFUN_EVAL_FUN(_eval_defvar, exp, env)
{
	return scheme_define_var(SCHEME_CAR(exp),
				 scheme_eval(SCHEME_CDR(exp), env),
				 env);
}

_DEFUN_EVAL_FUN(_eval_defun, exp, env)
{
	Scheme_obj_t *vars, *body;
	
	vars = SCHEME_CAR(SCHEME_CDR(exp));
	body = SCHEME_CDR(SCHEME_CDR(exp));
	
	
return scheme_define_var(SCHEME_CAR(exp),
				 scheme_make_procedure(vars, body, env),
				 env);
}

_DEFUN_EVAL_FUN(_eval_if, exp, env)
{
	Scheme_obj_t *pred, *cseq, *alter;

	pred = SCHEME_CAR(exp);
	cseq = SCHEME_CAR(SCHEME_CDR(exp));
	alter = SCHEME_CDR(SCHEME_CDR(exp));
	if (SCHEME_TRUEP(scheme_eval(pred, env)))
		return scheme_eval(cseq, env);
	else
		return scheme_eval(alter, env);
	
	return scheme_void;
}

_DEFUN_EVAL_FUN(_eval_lambda, exp, env)
{
	return scheme_make_procedure(
		SCHEME_CAR(exp), SCHEME_CDR(exp), env);
}

/* _eval_begin is same to scheme_eval_sequence */

_DEFUN_EVAL_FUN(_eval_cond, exp, env)
{
	Scheme_obj_t *p;

	while (!SCHEME_NULLP(exp)) {
		p = SCHEME_CAR(exp);
		if (SAME_OBJ(SCHEME_CAR(p), scheme_true) ||
		    SCHEME_TRUEP(scheme_eval(SCHEME_CAR(p), env)))
			return scheme_eval_sequence(SCHEME_CDR(p), env);
		exp = SCHEME_CDR(exp);
	}

	/* undefined return value there */
	return scheme_void;
}

_DEFUN_EVAL_FUN(_eval_application, exp, env)
{
	Scheme_obj_t *proc;

	proc = scheme_eval(SCHEME_CAR(exp), env);
	if (SCHEME_VOIDP(proc)) {
		#ifdef DEBUG_MSG
		printf("Undefined variable -- EVAL\n");
		#endif	/* DEBUG_MSG */
		return scheme_void;		
	}

	return scheme_apply(proc, _eval_list(SCHEME_CDR(exp), env));
}

_DEFUN_EVAL_FUN(_eval_and, exp, env)
{
	while (!SCHEME_NULLP(exp)) {
		if (SCHEME_FALSEP(scheme_eval(SCHEME_CAR(exp), env)))
			return scheme_false;
		exp = SCHEME_CDR(exp);
	}

	return scheme_true;
}

_DEFUN_EVAL_FUN(_eval_or, exp, env)
{
	while (!SCHEME_NULLP(exp)) {
		if (SCHEME_TRUEP(scheme_eval(SCHEME_CAR(exp), env)))
			return scheme_true;
		exp = SCHEME_CDR(exp);
	}

	return scheme_false;
}

_DEFUN_EVAL_FUN(_eval_list, exp, env)
{
	Scheme_obj_t *rslt, *p, *q;

	rslt = q = scheme_null;
	while (!SCHEME_NULLP(exp)) {
		p = scheme_make_pair(
			scheme_eval(SCHEME_CAR(exp), env),
			scheme_null);
		if (SCHEME_NULLP(q))
			rslt = p;
		else
			SCHEME_SET_CDR(q, p);
		q = p;
		exp = SCHEME_CDR(exp);
	}

	return rslt;
}

static Scheme_obj_t *_analyze_application(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	expr = _analyze_sequence(obj);
	SCHEME_SET_TYPE(expr, scheme_application_expr_type);
	
	return expr;
}

static Scheme_obj_t *_analyze_sequence(Scheme_obj_t *seq)
{
	Scheme_obj_t *expr, *p, *q;

	expr = q = scheme_null;
	while (!SCHEME_NULLP(seq)) {
		p = scheme_make_pair(
			_analyze(SCHEME_CAR(seq)),
			scheme_null);
		if (expr == scheme_null)
			expr = p;
		else
			SCHEME_SET_CDR(q, p);
		q = p;
		seq = SCHEME_CDR(seq);
	}
	SCHEME_SET_TYPE(expr, scheme_sequence_expr_type);
	
	return expr;
}

static Scheme_obj_t *_analyze_and(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;
	
	expr = _analyze_sequence(SCHEME_CDR(obj));
	SCHEME_SET_TYPE(expr, scheme_and_expr_type);

	return expr;
}

static Scheme_obj_t *_analyze_begin(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;
	
	expr = _analyze_sequence(SCHEME_CDR(obj));
	SCHEME_SET_TYPE(expr, scheme_begin_expr_type);

	return expr;
}

static Scheme_obj_t *_analyze_case(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
}

static Scheme_obj_t *_analyze_cond(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr, *p, *q, *r, *s;

	obj = SCHEME_CDR(obj); s = expr = scheme_null;
	while (!SCHEME_NULLP(obj)) {
		p = SCHEME_CAR(obj);
		q = _analyze(SCHEME_CAR(p));
		r = scheme_make_pair(
			scheme_make_pair(
				q, _analyze_sequence(SCHEME_CDR(p))),
			scheme_null);
		if (expr == scheme_null)
			expr = r;
		else
			SCHEME_SET_CDR(s, r);
		s = r;
		obj = SCHEME_CDR(obj);
	}
	SCHEME_SET_TYPE(expr, scheme_cond_expr_type);
	
	return expr;
}

static Scheme_obj_t *_analyze_definition(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr, *p, *var, *val;

	p = SCHEME_CAR(SCHEME_CDR(obj));
	if (SCHEME_SYMBOLP(p)) {
		var = p;
		val = _analyze(SCHEME_CAR(SCHEME_CDR(SCHEME_CDR(obj))));
		expr = scheme_make_pair(var, val);
		SCHEME_SET_TYPE(expr, scheme_defvar_expr_type);
	}
	else if (SCHEME_PAIRP(p)) {
		var = SCHEME_CAR(p);
		val = scheme_make_pair(
			SCHEME_CDR(p),
			_analyze_sequence(SCHEME_CDR(SCHEME_CDR(obj))));
		/* function should be created by runtime */
		expr = scheme_make_pair(var, val);
		SCHEME_SET_TYPE(expr, scheme_defun_expr_type);
	}
	
	return expr;
}

static Scheme_obj_t *_analyze_delay(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
}

static Scheme_obj_t *_analyze_loop(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
}

static Scheme_obj_t *_analyze_else(Scheme_obj_t *obj)
{
	return scheme_true;
}

static Scheme_obj_t *_analyze_if(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr, *p, *pred, *cseq, *alter;

	p = obj;
	p = SCHEME_CDR(p);
	if (SCHEME_PAIRP(p)) {
		pred = _analyze(SCHEME_CAR(p));
		p = SCHEME_CDR(p);
	}
	else {			/* Illegal form */
		return scheme_void;
	}
	if (SCHEME_PAIRP(p)) {
		cseq = _analyze(SCHEME_CAR(p));
		p = SCHEME_CDR(p);
	}
	if (SCHEME_PAIRP(p)) {
		if (!SCHEME_NULLP(SCHEME_CDR(p))) { /* Illegal form */
			
			return scheme_void;
		}
		alter = _analyze(SCHEME_CAR(p));
	}
	else if (SCHEME_NULLP(p))
		alter = scheme_null;
	else {			/* Illegal form */
		return scheme_void;
	}
	if (SCHEME_VOIDP(pred) || SCHEME_VOIDP(cseq) || SCHEME_VOIDP(alter)) {
		/* Illegal form */
		return scheme_void;
	}
	
	expr = scheme_make_pair(
		pred, scheme_make_pair(cseq, alter));
	SCHEME_SET_TYPE(expr, scheme_if_expr_type);

	return expr;
}

static Scheme_obj_t *_analyze_lambda(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr, *vars, *body;

	vars = SCHEME_CAR(SCHEME_CDR(obj));
	body = SCHEME_CDR(SCHEME_CDR(obj));
	expr = scheme_make_pair(vars, _analyze_sequence(body));
	SCHEME_SET_TYPE(expr, scheme_lambda_expr_type);
	
	return expr;
	
}

static Scheme_obj_t *_analyze_let(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
	
}

static Scheme_obj_t *_analyze_letrec(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
	
}

static Scheme_obj_t *_analyze_let_star(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
	
}

static Scheme_obj_t *_analyze_or(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;
	
	expr = _analyze_sequence(SCHEME_CDR(obj));
	SCHEME_SET_TYPE(expr, scheme_or_expr_type);

	return expr;
}

static Scheme_obj_t *_analyze_quasiquote(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	return expr;
	
}

static Scheme_obj_t *_analyze_quoted(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr;

	expr = scheme_alloc_obj();
	SCHEME_SET_TYPE(expr, scheme_quoted_expr_type);
	SCHEME_SET_CAR(expr,
		       SCHEME_CAR(SCHEME_CDR(obj)));
	
	return expr;
}

static Scheme_obj_t *_analyze_assignment(Scheme_obj_t *obj)
{
	Scheme_obj_t *expr, *var, *val;

	var = SCHEME_CAR(SCHEME_CDR(obj));
	if (!SCHEME_SYMBOLP(var)) { /* exception: */
		return scheme_void;
	}
	val = SCHEME_CAR(SCHEME_CDR(SCHEME_CDR(obj)));
	expr = scheme_make_pair(var, _analyze(val));
	SCHEME_SET_TYPE(expr, scheme_assignment_expr_type);
	
	return expr;
}

static _Analyze_func_t _find_keyword(char *key)
{
	int i, j, k;

	j = sizeof(_analyze_funcs_) / sizeof(struct _Analyze_func) - 1;
	
	for (i = k = 0; key[k] != '\0'; k++) {
		for (; i < j; i++)
			if ((_analyze_funcs_[i].name)[k] == key[k])
				break;
		if (i == j)
			return NULL;
		for (j = i + 1; _analyze_funcs_[j].name != NULL; j++)
			if ((_analyze_funcs_[j].name)[k] != key[k])
				break;
	}

	return _analyze_funcs_[i].fun;
}

