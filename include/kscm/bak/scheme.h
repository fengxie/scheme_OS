/* 
 * scheme.h --- short description
 * 
 * Copyright  (C)  2005  Wizard' Tse <keith@localhost.localdomain>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Wizard' Tse <keith@localhost.localdomain>
 * Maintainer: Wizard' Tse <keith@localhost.localdomain>
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

#ifndef KSCM_SCHEME_H
#define KSCM_SCHEME_H

#include <kscm/config.h>

#include <kscm/lispm.h>

enum scheme_constant {
/* to implement `boolean' as constant */
	SCHEME_TRUE = 0x00,
	SCHEME_FALSE = 0x01,
};

typedef lispm_addr_t scheme_obj_t;

#define SCHEME_TYPE(addr) (LISPM_TYPE(*LISPM_MAP_PMEM(addr)))
#define SCHEME_TAG(addr) (LISPM_TAG(*LISPM_MAP_PMEM(addr)))

/*
 * predications: (<pred> <lispm_addr_t a> <lispm_addr_t b>)
 */

/* equations */
#define SCHEME_EQP(a, b) (a == b? SCHEME_TRUE: SCHEME_FALSE)
#define SCHEME_EQVP(a, b)

/* type predications */
#define SCHEME_PAIRP(obj) (SCHEME_TYPE(obj) == LISPM_PAIR)
#define SCHEME_SYMBOLP(obj) (SCHEME_TYPE(obj) == LISPM_SYMBOL)
#define SCHEME_STRING(obj) (SCHEME_TYPE(obj) == LISPM_STRING)
#define SCHEME_VECTORP(obj) (SCHEME_TYPE(obj) == LISPM_VECTOR)

#define SCHEME_PRIMITIVE_PROCP(obj) (SCHEME_TYPE(obj) == LISPM_PRIMITIVE_PROC)
#define SCHEME_COMPONENT_PROCP(obj) (SCHEME_TYPE(obj) == LISPM_COMPONENT_PROC)
#define SCHEME_PROCP(obj) (SCHEME_PRIMITIVE_PROCP(obj) &&	\
		SCHEME_COMPONENT_PROCP(obj))

#define SCHEME_CHARP(obj) (SCHEME_TYPE(obj) & LISPM_CHAR != 0)

/*
 *  builtin procedures(primitive procedures)
 *  format: scheme_<proc-name>
 */

/* the `eval' procedure call the `apply' by <proc> and <args> */

/* they will be called via apply-primitive-procedure */
/* :: string -> obj */
scheme_obj_t scheme_read(scheme_obj_t args);
/* :: for all obj. obj -> string */
scheme_obj_t scheme_display(scheme_obj_t args);

/* :: for all a, b. (a . b) -> a */
scheme_obj_t scheme_car(scheme_obj_t args);
/* :: for all a, b. (a . b) -> b */
scheme_obj_t scheme_cdr(scheme_obj_t args);
/* :: for all a, b. a -> b -> (a . b)*/
scheme_obj_t scheme_cons(scheme_obj_t args);
/* :: for all a. a -> (a) */
scheme_obj_t scheme_list(scheme_obj_t args);

scheme_obj_t scheme_plus(scheme_obj_t args);
scheme_obj_t scheme_minus(scheme_obj_t args);

/* do not need pass current environment explicitly
 * because there is a lisp machine which hold on the
 * global state for execution of lisp expression */
scheme_obj_t scheme_eval(scheme_obj_t args);

#endif	/* KSCM_SCHEME_H */
