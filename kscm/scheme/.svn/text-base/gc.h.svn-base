/* 
 * gc.h --- garbage collector based on the liftimes of objects
 *
 *  HENRY LIEBERMAN AND CARL HEWITT MIT Artificial Intelligence
 *  Laboratory
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

#ifndef GC_H
#define GC_H

#include "scheme.h"

#define SCHEME_KEY(obj) ((obj)->keyex)
#define SCHEME_FORWARD(obj) ((obj)->u.forward)

#define SCHEME_EVACUATED(obj) (SCHEME_KEY(obj) & 0x1)

#define _ENTRY_TABLE_SIZE 128

typedef struct Entry_table {
	int entry_cnt;
	
	struct Entry {
		Scheme_type type;

		short gen_numb;	/* pointer from which generation */
		Scheme_obj_t *ptr;
	} table[_ENTRY_TABLE_SIZE];
} Entry_table_t;

#define ENTRY_TABLE_CNT(t) ((t)->entry_cnt)
#define ENTRY_PTR(entry) ((entry)->ptr)

#include <kscm/config.h>

#define DEFAULT_REGION_SIZE (1 * K_PG_SIZE)

typedef struct Region {
	union {
		struct {
			struct Region *prev;
			struct Region *next;

			short gen_numb;
			short version;
			short size;

			Entry_table_t *entry_table;
			Scheme_obj_t *top;	/* point to next free slot */
		} head;
		struct {
			Scheme_obj_t __a1, __a2;
		} __align;
	} u;
	
	Scheme_obj_t slots[0];
} Region_t;

#define REGION_PREV(reg) ((reg)->u.head.prev)
#define REGION_NEXT(reg) ((reg)->u.head.next)
#define REGION_GEN_NUMB(reg) ((reg)->u.head.gen_numb)
#define REGION_VERSION(reg) ((reg)->u.head.version)
#define REGION_SIZE(reg) ((reg)->u.head.size)
#define REGION_TOP(reg) ((reg)->u.head.top)
#define REGION_TABLE(reg) ((reg)->u.head.entry_table)

#define REGION_FULL_P(reg) (((void *)REGION_TOP(reg) - (void *)(reg)) == DEFAULT_REGION_SIZE)

void scheme_init_gc(Scheme_env_t *env);
Scheme_obj_t *gc_alloc_obj();
Scheme_obj_t *gc_alloc_nobj(int n);
/* force to do garbage collection */
Scheme_obj_t *gc_collect_garbage();

#if (DEFAULT_REGION_SIZE != K_PG_SIZE)
#error macro DEFAULT_REGION_SIZE must match the K_PG_SIZE
#endif	/* Test region size */

static inline struct Entry *_add_entry(struct Entry_table *t, Region_t *from, Scheme_obj_t *to)
{
	int i;
	
	for (i = 0; i < _ENTRY_TABLE_SIZE; i++)
		if (t->table[i].gen_numb == -1) {
			t->table[i].type = scheme_entry_type;
			t->table[i].gen_numb = REGION_GEN_NUMB(from);
			t->table[i].ptr = to;
			return t->table + i;
		}

	/* fatal error */
	return NULL;
}

static inline Region_t *_belong_which_gen(Scheme_obj_t *obj)
{
	return (Region_t *)((unsigned long)obj & ~0xfff);
}

static inline Scheme_obj_t *scheme_ref_obj(Scheme_obj_t **obj)
{
	struct Entry *p;
	
	switch (SCHEME_TYPE(*obj)) {
	case scheme_forward_type:
		*obj = SCHEME_FORWARD(*obj);
		break;
	case scheme_entry_type:
		p = (struct Entry *)(*obj);
		if (SCHEME_TYPE(ENTRY_PTR(p)) == scheme_forward_type)
			ENTRY_PTR(p) = SCHEME_FORWARD(p->ptr);
		return ENTRY_PTR(p);
		break;
	default:
		break;
	}

	return *obj;
}

/* re-defined accessors */
static inline Scheme_obj_t *scheme_car(Scheme_obj_t *pair)
{
	return scheme_ref_obj(&(pair->u.pair.car));
}

static inline Scheme_obj_t *scheme_set_car(Scheme_obj_t *pair, Scheme_obj_t *obj)
{
	Region_t *p, *q;
	struct Entry *entry;

	p = _belong_which_gen(pair);
	q = _belong_which_gen(obj);
	/* q is newer than p */
	if (REGION_GEN_NUMB(p) < REGION_GEN_NUMB(q)) {
		entry = _add_entry(REGION_TABLE(q), p, obj);
		if (entry == NULL) /* fatal error */
			return scheme_void;
		pair->u.pair.car = (Scheme_obj_t *)entry;
	}
	return (pair->u.pair.car = obj);
}

static inline Scheme_obj_t *scheme_cdr(Scheme_obj_t *pair)
{
	return scheme_ref_obj(&(pair->u.pair.cdr));
}

static inline Scheme_obj_t *scheme_set_cdr(Scheme_obj_t *pair, Scheme_obj_t *obj)
{
	Region_t *p, *q;
	struct Entry *entry;

	p = _belong_which_gen(pair);
	q = _belong_which_gen(obj);
	/* q is newer than p */
	if (REGION_GEN_NUMB(p) < REGION_GEN_NUMB(q)) {
		entry = _add_entry(REGION_TABLE(q), p, obj);
		if (entry == NULL) /* fatal error */
			return scheme_void;
		pair->u.pair.cdr = (Scheme_obj_t *)entry;
	}
	
	return (pair->u.pair.cdr = obj);
}

static inline Scheme_obj_t *scheme_sym_get_env(Scheme_obj_t *sym)
{
	
}

static inline Scheme_obj_t *scheme_vector_ref(Scheme_obj_t *vector, int idx)
{
	if (idx >= vector->u.vector.len)
		return scheme_void;
	
	return scheme_ref_obj((vector->u.vector.buf) + idx);
}

static inline Scheme_obj_t *scheme_proc_paras(Scheme_obj_t *proc)
{
	return scheme_ref_obj(&(proc->u.cpd_proc.paras));
}

static inline Scheme_obj_t *scheme_proc_body(Scheme_obj_t *proc)
{
	return scheme_ref_obj(&(proc->u.cpd_proc.body));
}

static inline Scheme_env_t *scheme_proc_env(Scheme_obj_t *proc)
{
	return scheme_ref_obj(&(proc->u.cpd_proc.env));
}

static inline Scheme_obj_t *scheme_env_get_name(Scheme_env_t *env)
{
	
}

static inline Scheme_env_t *scheme_env_enclosing(Scheme_env_t *env)
{
	return scheme_ref_obj(&(env->u.env.enclosing));
}

static inline Scheme_env_t *scheme_env_set_enclosing(Scheme_env_t *env, Scheme_env_t *enclosing)
{
	return scheme_ref_obj(&(env->u.env.enclosing));
}

#endif	/* GC_H */
