/* 
 * builtin.h --- short description
 * 
 * Copyright  (C)  2006  Fung Tse <wikeithtse@gmail.com>
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

/* Why the builtin function doesn't use LEAVE_PROC to return to
 * caller? If I use this mechanism, the continuation
 * should be save when a builtin function is called at non-tail position.
 * Actually, it is no need for calling a builtin function, and it 
 * will cost much time to save continuation, which we should reduce
 * as much as possible. */

#ifndef BUILTIN_H
#define BUILTIN_H

#include <svm.h>

/* interface to help call builtin functions
 * - This interface prevent compiler from generating unexepted code
 * - that might change stack pointer. So we do it ourselves. */
#define call_builtin(func, argc_) do {					\
		svm_register(argc) = argc_;				\
		__asm__ volatile (					\
			"call " C_SYM_TO_ASM(func) "\n\t"		\
			::						\
			: "memory");					\
	} while (0)

#define leave_builtin(v) do {			\
		svm_register(value) = (v);	\
		return;				\
	} while (0)

/* If we have a GNU C compiler we can use this macro to help us defining
 * interface for call builtin functions */
#ifdef __GNUC__

#define DEFINE_BUILTIN(func)						\
	void builtin_ ## func();					\
	static inline void M_builtin_ ## func (int argc)		\
	{								\
		call_builtin(builtin_ ## func, argc);			\
	}

#define M_builtin_psvmst(argc) do {			\
		call_builtin(print_vm_state, argc);	\
	} while (0)

#else  /* You don't have GNU C compiler :-( */

#error Need GUNC to compiler this program

#endif	/* __GNUC__ */


/* (null? ...) */
#define M_builtin_null_p(argc) do {				\
		svm_register(value) =				\
			SCHEME_NULLP(svm_register(value)) ?	\
			scheme_true: scheme_false;		\
	} while (0)

/* operations for S-exp */
#define M_builtin_car(argc) do {				\
		if (SCHEME_NULLP(g_svm.reg_value))		\
			break;					\
		g_svm.reg_value = SCHEME_CAR(*g_svm.stack_top);	\
	} while (0)

#define M_builtin_cdr(argc) do {				\
		if (SCHEME_NULLP(g_svm.reg_value))		\
			break;					\
		g_svm.reg_value = SCHEME_CDR(*g_svm.stack_top);	\
	} while (0)

#include <builtins/display.h>
#include <builtins/numb.h>

#endif
