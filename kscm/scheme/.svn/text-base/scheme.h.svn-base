/* 
 * scheme.h --- short description
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

#ifndef SCHEME_H
#define SCHEME_H

/* 
 * License
 * -------
 * 
 * PLT Software
 * Copyright (c) 1995-2003 PLT
 * Copyright (c) 2004 PLT Inc.
 * 
 * PLT software is distributed under the GNU Lesser General Public License
 * (LGPL).  This means you can link PLT software (such as MzScheme or
 * MrEd) into proprietary applications, provided you follow the specific
 * rules stated in the LGPL.  You can also modify PLT software; if you
 * distribute a modified version, you must distribute it under the terms
 * of the LGPL, which in particular means that you must release the source
 * code for the modified software.  See notes/COPYING.LIB for more
 * information.
 */
enum Scheme_types {
	scheme_env_type,
	scheme_forward_type,
	scheme_entry_type,

	_scheme_values_types_, /* All following types are values */

	/* from source of mzscheme */
	/* procedure types */
	scheme_prim_proc_type,
	scheme_cpd_proc_type,
	scheme_closure_type,
	scheme_proc_struct_type,

	/* basic types */
	scheme_char_type,	/* 7 */
	scheme_number_type,
	scheme_integer_type,
	scheme_bignum_type,	/* not be implemented */
	scheme_rational_type,
	scheme_real_type,
	scheme_float_type,
	scheme_double_type,
	_scheme_number_type_,

	scheme_string_type,	/* 15 */
	scheme_symbol_type,
	scheme_null_type,
	scheme_pair_type,
	scheme_vector_type,
	scheme_input_port_type,
	scheme_output_port_type,
	scheme_eof_type,
	scheme_bool_type,
	scheme_void_type,
	scheme_lazy_macro_type,

	_scheme_expr_type_,	/* 26 */
	scheme_self_evaluating_type,
	scheme_quoted_expr_type,
	scheme_variable_expr_type,
	scheme_assignment_expr_type,
	scheme_defvar_expr_type,
	scheme_defun_expr_type,
	scheme_if_expr_type,
	scheme_lambda_expr_type,
	scheme_begin_expr_type,
	scheme_sequence_expr_type,
	scheme_cond_expr_type,
	scheme_application_expr_type,
	scheme_and_expr_type,
	scheme_or_expr_type,

	scheme_else_clause_type,
	
	scheme_undefined_type,	/* 42 */
};

typedef short Scheme_type;

typedef int Scheme_char_t;
typedef int Scheme_int_t;
typedef double Scheme_double_t;
typedef enum Bool {
	scheme_true_val,
	scheme_false_val,
} Scheme_bool_t;

/* subtypes of scheme_port_type */
enum Scheme_port_types {
	scheme_port_char_stream_type = 0,
	scheme_port_file_stream_type = 1,
	scheme_port_direct_input_type, /* temp type used for direct
					* input from keyboard port */
};

typedef struct Scheme_obj Scheme_obj_t;
typedef Scheme_obj_t *(*Scheme_local_func_t)(int argc, Scheme_obj_t *argv[]);
typedef struct Scheme_prim_bind {
	char *name;
	Scheme_local_func_t fun;
	int mina, maxa;
} Scheme_prim_bind_t;

/* #define USE_ENV2 */

#ifdef USE_ENV2

typedef struct Scheme_env {
	short ref_cnt;
	short deepth;
	short bind_cnt;
	short max_bind;

	struct Scheme_env *enclosing;
	struct Binding {
		struct Scheme_obj *var, *val;
	} *bindings;
} Scheme_env_t;

#else

typedef struct Scheme_bindings {
	short bind_cnt;
	short max_bind;

	struct Binding {
		struct Scheme_obj *var, *val;
	} *binds;
} Scheme_bindings_t;

typedef struct Scheme_obj Scheme_env_t;

#endif	/* USE_ENV2 */

struct Scheme_obj {
	Scheme_type type;

	short keyex;

	union {
		struct {
			Scheme_obj_t *car, *cdr;
		} pair;
		struct {
			char *str;
			int tag_val; /* 16-lower bits used as str_len
				      * 16-higher bits used as hash
				      * key for symbol */
			Scheme_env_t *env;
		} symbol;
		struct {
			Scheme_obj_t **buf;
			int len;
		} vector;

		/* Scheme_char_t char_val; */
		Scheme_int_t int_val;
		struct {
			Scheme_int_t v1, v2;
		} int_pair;
		Scheme_double_t dbl_val;
		struct {
			char *str;
			int len; 
		} str_val;
		Scheme_bool_t bool_val;		/* While be implemented as constant */

		struct {
			Scheme_local_func_t builtin;
			int mina, maxa;
		} prim_proc;
		struct {
			Scheme_obj_t *paras, *body;
			Scheme_env_t *env;
		} cpd_proc;
		struct {
			void *stream; /* stream object */
			int tag_val;
		} port;

		#ifdef USE_ENV2
		Scheme_env_t *env;
		#else
		struct {
			Scheme_obj_t *name; /* symbol for name */
			Scheme_bindings_t *bindings; /* ((..) . (..)) */
			Scheme_env_t *enclosing;
		} env;
		#endif	/* USE_ENV2 */
		struct {
			int length;
			char str[0];
		} str2;
		struct {
			int length;
			Scheme_obj_t *vector[0];
		} vector2;
		
		Scheme_obj_t *forward; /* point to object in tospace */
	} u;
};

typedef Scheme_obj_t Scheme_expr_t;

/* from source of mzscheme */
#define OBJ_TO_LONG(ptr) ((long)(ptr))
#define LONG_TO_OBJ(l) ((Scheme_obj_t *)(void *)(long)(l))

#define SCHEME_CHARP(obj)     (OBJ_TO_LONG(obj) & 0x1)
#define SCHEME_CHAR_TO_OBJ(c) LONG_TO_OBJ(((long)(c) << 1) | 0x1)

#define SAME_PTR(a, b) ((a) == (b))
#define NOT_SAME_PTR(a, b) ((a) != (b))

#define SAME_OBJ(a, b) SAME_PTR(a, b)
#define NOT_SAME_OBJ(a, b) NOT_SAME_PTR(a, b)

#define SAME_TYPE(a, b) ((Scheme_type)(a) == (Scheme_type)(b))
#define NOT_SAME_TYPE(a, b) ((Scheme_type)(a) != (Scheme_type)(b))

#define SCHEME_TYPE(obj)     (SCHEME_CHARP(obj)?(Scheme_type)scheme_char_type:(obj)->type)

#include <stdlib.h>

/* Use constant memory location to express constant value to
 * reduce cost for creating these object dynamically */
extern Scheme_obj_t scheme_null[1];
extern Scheme_obj_t scheme_void[1];
extern Scheme_obj_t scheme_true[1];
extern Scheme_obj_t scheme_false[1];
extern Scheme_obj_t scheme_eof[1];

/* Basic Scheme predicates */
/* SCHEME_CHARP is defined above */
#define SCHEME_INTP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_integer_type))
#define SCHEME_RATP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_rational_type))
#define SCHEME_DOUBLEP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_double_type))
#define SCHEME_BOOLP(obj) ((obj) == scheme_true || (obj) == scheme_false)

#define SCHEME_STRINGP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_string_type))

#define SCHEME_FALSEP(obj) (SAME_OBJ(obj, scheme_false))
#define SCHEME_TRUEP(obj) (!SCHEME_FALSEP(obj))

#define SCHEME_VOIDP(obj) (SAME_OBJ((obj), scheme_void))

#define SCHEME_EOFP(obj) (SAME_OBJ(obj, scheme_eof))
#define SCHEME_INPUT_PORTP(obj) SAME_TYPE(SCHEME_TYPE(obj), scheme_input_port_type)
#define SCHEME_OUTPUT_PORTP(obj) SAME_TYPE(SCHEME_TYPE(obj), scheme_output_port_type)


#define SCHEME_NULLP(obj) (SAME_OBJ(obj, scheme_null))
#define SCHEME_PAIRP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_pair_type))
#define SCHEME_SYMBOLP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_symbol_type))
#define SCHEME_VECTORP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_vector_type))
#define SCHEME_PROCEDUREP(obj) (SAME_TYPE(SCHEME_TYPE(obj), scheme_cpd_proc_type) || \
				SAME_TYPE(SCHEME_TYPE(obj), scheme_prim_type))

/* Basic Scheme accessors */
/* these accessors do not concern what type the `obj' is and assume it
 * is the just type that they expect */
#define SCHEME_CHAR_VAL(obj) ((char)((OBJ_TO_LONG(obj) >> 1) & 0xff))
#define SCHEME_INT_VAL(obj) ((obj)->u.int_val)
#define SCHEME_INT_PAIR_V1(obj) ((obj)->u.int_pair.v1)
#define SCHEME_INT_PAIR_V2(obj) ((obj)->u.int_pair.v2)
#define SCHEME_DBL_VAL(obj) ((obj)->u.dbl_val)
#define SCHEME_STR_VAL(obj) ((obj)->u.str_val.str)
#define SCHEME_STR_LEN(obj) ((obj)->u.str_val.len)
#define SCHEME_BOOL_VAL(obj) ((obj)->u.bool_val)

#define SCHEME_CAR(obj) ((obj)->u.pair.car)
#define SCHEME_CDR(obj) ((obj)->u.pair.cdr)
#define SCHEME_SYMBOL_VAL(obj) ((obj)->u.symbol.str)
#define SCHEME_SYMBOL_KEY(obj) (((obj)->u.symbol.tag_val & 0xffff0000) >> 16)
#define SCHEME_SYMBOL_LEN(obj) ((obj)->u.symbol.tag_val & 0x0000ffff)
#define SCHEME_VECTOR_LEN(obj) ((obj)->u.vector.len)
#define SCHEME_VECTOR_BUF(obj) ((obj)->u.vector.buf)

#define SCHEME_PORT_TYPE(obj) ((obj)->u.port.tag_val & 0x3)
#define SCHEME_PORT_STREAM(obj) ((obj)->u.port.stream)
#define SCHEME_PORT_TAG(obj) ((obj)->u.port.tag_val)
#define SCHEME_PORT_STREAM_OFF(obj) ((obj)->u.port.tag_val >> 2)
#define SCHEME_PORT_STREAM_INC_OFF(obj) ((obj)->u.port.tag_val += 4)

#define SCHEME_SET_TYPE(obj, t) ((obj)->type = (t))

#define SCHEME_SET_INT(obj, val) ((obj)->u.int_val = (val))
#define SCHEME_SET_INT_PAIR_V1(obj, v) ((obj)->u.int_pair.v1 = (v))
#define SCHEME_SET_INT_PAIR_V2(obj, v) ((obj)->u.int_pair.v2 = (v))
#define SCHEME_SET_DOUBLE(obj, val) ((obj)->u.dbl_val = (val))
#define SCHEME_SET_STR(obj, s) ((obj)->u.str_val.str = (s))
#define SCHEME_SET_STR_LEN(obj, l) ((obj)->u.str_val.len = (l))

#define SCHEME_SET_BOOL(obj, val) ((obj)->u.bool_val = (val))

#define SCHEME_SET_CAR(obj, ptr) ((obj)->u.pair.car = (ptr))
#define SCHEME_SET_CDR(obj, ptr) ((obj)->u.pair.cdr = (ptr))

#define SCHEME_SET_SYMBOL(obj, s) ((obj)->u.symbol.str = (s))
#define SCHEME_SET_SYMBOL_KEY(obj, key) ((obj)->u.symbol.tag_val = (key))
#define SCHEME_SET_SYMBOL_LEN(obj, len) (((obj)->u.symbol.tag_val & 0xffff0000) | ((len) & 0x0000ffff))

#define SCHEME_SET_VECTOR_BUF(obj, b) ((obj)->u.vector.buf = (b))
#define SCHEME_SET_VECTOR_LEN(obj, l) ((obj)->u.vector.len = (l))

#define SCHEME_SET_PORT_STREAM(obj, s) ((obj)->u.port.stream = (s))
#define SCHEME_SET_PORT_TAG(obj, t) ((obj)->u.port.tag_val = (t))

#define SCHEME_PROC_PARAS(obj) ((obj)->u.cpd_proc.paras)
#define SCHEME_PROC_BODY(obj) ((obj)->u.cpd_proc.body)
#define SCHEME_PROC_ENV(obj) ((obj)->u.cpd_proc.env)

#define SCHEME_SET_PROC_PARAS(obj, p) ((obj)->u.cpd_proc.paras = (p))
#define SCHEME_SET_PROC_BODY(obj, b) ((obj)->u.cpd_proc.body = (b))
#define SCHEME_SET_PROC_ENV(obj, e) ((obj)->u.cpd_proc.env = (e))

#ifdef USE_ENV2

#define SCHEME_ENV(obj) ((obj)->u.env)
/* accessors */
#define SCHEME_ENV_ENCLOSING(e) ((e)->enclosing)
#define SCHEME_ENV_BINDING(e) ((e)->bindings)

#define SCHEME_ENV_REF_CNT(env) ((env)->ref_cnt)
#define SCHEME_ENV_DEEPTH(env) ((env)->deepth)
#define SCHEME_ENV_BIND_CNT(env) ((env)->bind_cnt)
#define SCHEME_ENV_MAX_BIND(env) ((env)->max_bind)

/* update macros */
#define SCHEME_ENV_INC_REF_CNT(env) (((env)->ref_cnt)++)
#define SCHEME_ENV_DEC_REF_CNT(env) (--((env)->ref_cnt))

#define SCHEME_SET_ENV_ENCLOSING(e, c) ((e)->enclosing = (c))
#define SCHEME_SET_ENV_BINDING(e, b) ((e)->bindings = (b))

#else  /* does not use ENV2 */

#define SCHEME_ENV(obj) (obj)

#define SCHEME_ENV_NAME(e) ((e)->u.env.name)
#define SCHEME_ENV_ENCLOSING(e) ((e)->u.env.enclosing)
#define SCHEME_ENV_BINDING(e) ((e)->u.env.bindings)

#define SCHEME_SET_ENV_NAME(e, n) ((e)->u.env.name = (n))
#define SCHEME_SET_ENV_ENCLOSING(e, c) ((e)->u.env.enclosing = (c))
#define SCHEME_SET_ENV_BINDING(e, b) ((e)->u.env.bindings = (b))

#endif	/* USE_ENV2 */

#define SCHEME_PRIM_FUN(obj) ((obj)->u.prim_proc.builtin)
#define SCHEME_PRIM_MAXA(obj) ((obj)->u.prim_proc.maxa)
#define SCHEME_PRIM_MINA(obj) ((obj)->u.prim_proc.mina)

#define SCHEME_SET_PRIM_FUN(obj, fun) ((obj)->u.prim_proc.builtin = (fun))
#define SCHEME_SET_PRIM_MAXA(obj, max) ((obj)->u.prim_proc.maxa = (max))
#define SCHEME_SET_PRIM_MINA(obj, min) ((obj)->u.prim_proc.mina = (min))

#define DEFUN_LOCAL(fn_name) static Scheme_obj_t *fn_name(int argc, Scheme_obj_t *argv[])
/* new version for ``DEFUN_LOCAL'' */
#define SCHEME_DEFUN(fn_name, argc, argv) static Scheme_obj_t *	\
	fn_name(int argc, Scheme_obj_t*argv[])

#define TEST

void scheme_init();

#endif
