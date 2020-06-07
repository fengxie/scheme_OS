/* 
 * gc.c --- implementation of garbage collector
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
 * Regions are maintained by two doubly linked list ``free_list'' and
 * ``allocated_list''. For ``allocated_list'', the newest generation
 * pointed by ``__coordinator''.
 * 
 * Code:
 */

#include "gc.h"
#include "scheme.h"

#include <kscm/mm.h>

#include <stdlib.h>

/* locals. provide a interface for interpreter */

/* ``coordinator'' and ``natural'' come from ``Gundam Seed'' :-) */
/* the newest generation of objects */
static Region_t *__coordinator;
/* the oldest generation of objects */
static Region_t *__natural;

static Region_t *__regions;
static Region_t *__free_regions;

static Region_t *_alloc_region();
static void _free_region(Region_t *reg);

static Region_t *_new_generation();
static int _condemn_region(Region_t *reg);

/* call stack for eval */
static Scheme_env_t *__eval_stack[MAX_EVAL_STACK_SIZE];
static Scheme_env_t **__stack_base;
static Scheme_env_t **__stack_top;

static inline void _init_eval_stack()
{
	__stack_top = __stack_base = __eval_stack + MAX_EVAL_STACK_SIZE;
}

int eval_stack_empty_p()
{
	return __stack_base == __stack_top;
}

int eval_stack_full_p()
{
	return __stack_top == __eval_stack;
	
}

Scheme_env_t *eval_stack_pop_env()
{
	if (__stack_base == __stack_top)
		return NULL;
	
	return *__stack_top++;
}

int eval_stack_push_env(Scheme_env_t *env)
{
	if (eval_stack_full_p())
		return -1;
	
	*(--__stack_top) = env;
	return 0;
}

void scheme_init_gc(Scheme_env_t *env)
{
	__regions = __natural = __coordinator = NULL;
	__free_regions = NULL;

	_init_eval_stack();
	if (_new_generation() == NULL)
		return ;
}

Scheme_obj_t *gc_alloc_obj()
{
	if (REGION_FULL_P(__coordinator))
		_new_generation();

	return REGION_TOP(__coordinator)++;
}

Scheme_obj_t *gc_alloc_nobj(int n)
{
	
}

Scheme_obj_t *gc_collect_garbage()
{
	
}

/* locals */
static Region_t *_alloc_region()
{
	Region_t *reg;

	reg = __free_regions;
	/* remove from free list */
	if (reg == NULL) {
		reg = expand_region(mm_slots);
	}
	else {
		if (REGION_NEXT(reg) == reg)
			__free_regions = NULL;
		else {
			REGION_NEXT(REGION_PREV(reg)) = REGION_NEXT(reg);
			REGION_PREV(REGION_NEXT(reg)) = REGION_PREV(reg);
		}
	}

	return reg;
}

static void _free_region(Region_t *reg)
{
	/* insert to free list */
	if (__free_regions == NULL) {
		__free_regions = reg;
		REGION_PREV(reg) = reg;
		REGION_NEXT(reg) = reg;
	}
	else {
		REGION_NEXT(reg) = __free_regions;
		REGION_PREV(reg) = REGION_PREV(__free_regions);
		REGION_NEXT(REGION_PREV(__free_regions)) = reg;
		REGION_PREV(__free_regions) = reg;
	}
}

static Region_t *_new_generation()
{
	short new_gen;
	Region_t *reg;
	Entry_table_t *t;

	t = (Entry_table_t *)malloc(sizeof(Entry_table_t));
	if (t == NULL) {
		return NULL;
	}
	ENTRY_TABLE_CNT(t) = 0;
	
	reg = _alloc_region();
	if (reg == NULL) {
		free(t);
		return NULL;
	}

	if (__coordinator == NULL) { /* first generation */
		new_gen = 0;
		__regions = __natural = reg;
		REGION_NEXT(reg) = reg;
		REGION_PREV(reg) = reg;
	}
	else {
		new_gen = REGION_GEN_NUMB(__coordinator) + 1;
		REGION_PREV(reg) = __coordinator;
		REGION_NEXT(__coordinator) = reg;
		REGION_PREV(__regions) = reg;
		REGION_NEXT(reg) = __regions;
	}
	REGION_GEN_NUMB(reg) = new_gen;
	REGION_VERSION(reg) = 0;
	REGION_SIZE(reg) = DEFAULT_REGION_SIZE;
	REGION_TOP(reg) = reg->slots;
	REGION_TABLE(reg) = t;
	__coordinator = reg;
	
	return reg;
}

static int _condemn_region(Region_t *reg)
{
	
}
