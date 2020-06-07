/* 
 * svm.h --- short description
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
 * Description of scheme virtual machine
 * 
 * Code:
 */


#ifndef SVM_H
#define SVM_H

#include <scheme.h>

#include <assert.h>

#define SVM_TEMP_REGS 32

typedef struct Scheme_VM {
	/* logical registers */
	Scheme_Obj_t *reg_value;	/* value */
	Scheme_Obj_t *reg_new;		/* new object */
	Scheme_Envt_t *reg_envt;	/* current environment */
	Scheme_Cont_t *reg_cont;	/* continuation chain */
	Scheme_Template_t *reg_template;
	int reg_argc;
	Compiled_Code_t reg_pc;
	Scheme_Obj_t *reg_temp[SVM_TEMP_REGS];	/* temp registers */

	/* inner registers */
	Scheme_Binds_t reg_bindings;

	/* eval stack */
	Scheme_Obj_t **stack_base;
	Scheme_Obj_t **stack_top;
	Scheme_Obj_t **stack_start;
	int stack_size;
} Scheme_VM_t;

extern Scheme_VM_t g_svm;

int svm_init(Scheme_Envt_t *envt, Scheme_Obj_t **stack_start, int stack_size);

/* Basic accessors */
#define svm_register(regname) (g_svm.reg_ ## regname)
#define set_reg_value(obj) (g_svm.reg_value = (Scheme_Obj_t *)(obj))

#define svm_push() do {						\
		if (g_svm.stack_top == g_svm.stack_start)	\
			/* stack overflow */			\
			return;					\
		*(--g_svm.stack_top) = g_svm.reg_value;		\
	} while(0)

#define svm_pop() do {						\
		if (g_svm.stack_top == g_svm.stack_base)	\
			/* stack empty */			\
			return;					\
		g_svm.reg_value = *(g_svm.stack_top++);		\
	} while(0)

void save_continuation(void *next_instr);

/* some definition for c compiler */
#include <cc.h>

#include <gc.h>

/* all macro should not modify the %esp */
#define SCHEME_SAVE_CONT(cont) do {					\
		OBJ_TO_CONT(cont)->next = g_svm.reg_cont;		\
		OBJ_TO_CONT(cont)->reg_envt = g_svm.reg_envt;		\
		OBJ_TO_CONT(cont)->reg_template = g_svm.reg_template;	\
		OBJ_TO_CONT(cont)->reg_pc = g_svm.reg_pc;		\
		OBJ_TO_CONT(cont)->stack_base = g_svm.stack_base;	\
		OBJ_TO_CONT(cont)->stack_top = g_svm.stack_top;		\
	} while(0)

#define push_continuation(resume) do {					\
		__asm__ volatile (					\
			"movl $" #resume ", %0\n\t"			\
			: "=a"(g_svm.reg_pc)				\
			:: "memory");					\
		new_obj(scheme_cont_type, sizeof(Scheme_Cont_t));	\
		if (g_svm.reg_new == NULL) {				\
			return;						\
		}							\
		SCHEME_SAVE_CONT(g_svm.reg_new);			\
		g_svm.reg_cont = (Scheme_Cont_t *)g_svm.reg_new;	\
	} while(0)

#define apply_procedure() do {						\
		g_svm.reg_template =					\
			SCHEME_CLOSURE_TEMPLATE(g_svm.reg_value);	\
		g_svm.reg_envt =					\
			SCHEME_CLOSURE_ENVT(g_svm.reg_value);		\
		__asm__ volatile (					\
			"jmp *%0\n\t"					\
			:						\
			: "a"(g_svm.reg_template->code));		\
	} while (0)

#define resume_continuation() do {				\
		g_svm.reg_envt = g_svm.reg_cont->reg_envt;	\
		g_svm.reg_template =				\
			g_svm.reg_cont->reg_template;		\
		g_svm.reg_pc = g_svm.reg_cont->reg_pc;		\
		g_svm.reg_cont = g_svm.reg_cont->next;		\
		g_svm.reg_bindings = g_svm.reg_envt->bindings;	\
		__asm__ volatile (				\
			"jmp *%0\n\t"				\
			:					\
			: "a"(g_svm.reg_pc));			\
	} while(0)

#define PROC_ENTRY(label) __asm__ volatile (C_SYM_TO_ASM(label) ":\n\t")
#define BEGIN_PROC(label) __asm__ volatile (C_SYM_TO_ASM(label) ":\n\t")
#define LEAVE_PROC() resume_continuation()

/* set a label for address of instruction */
#define LABEL(label) __asm__ volatile (#label ":\n\t")
#define GOTO(label) __asm__ volatile ("jmp " #label "\n\t")
#define MOVESP(offset) (g_svm.stack_top += (offset))
#define movesp(offset) (g_svm.stack_top += (offset))
#define LOAD_ENVT(envt) do {					\
		g_svm.reg_envt = (Scheme_Envt_t *)(envt);	\
		g_svm.reg_bindings = g_svm.reg_envt->bindings;	\
	} while (0)
#define EXTEND_ENVT(envt) do {						\
		((Scheme_Envt_t *)(envt))->enclosing = g_svm.reg_envt;	\
		LOAD_ENVT(envt);					\
	} while (0)
#define NEW_OBJECT(type_dec, type) do {		\
		__asm__ volatile (					\
			"pushl %1\n\t"					\
			"pushl %0\n\t"					\
			"call " C_SYM_TO_ASM(gc_alloc_obj) "\n\t"	\
			"addl $8, %%esp\n\t"				\
			:						\
			: "a"(type), "d"((sizeof(type_dec)))		\
			: "memory");					\
	} while (0)
#define LOOKUP_VAR(envt, offset)				\
	(g_svm.reg_value = SCHEME_GET_VAR(envt, offset))
#define BIND_VAR(envt, offset)					\
	(SCHEME_GET_VAR(envt, offset) = g_svm.reg_value)
#define BIND_VAR_WITH_VAL(envt, offset, val)	\
	(SCHEME_GET_VAR(envt, offset) = (val))
#define ACCESS_STACK(offset) do {					\
		if (g_svm.stack_top + offset >= g_svm.stack_base)	\
			assert(0);					\
		g_svm.reg_value = g_svm.stack_top[offset];		\
	} while (0)


#endif
