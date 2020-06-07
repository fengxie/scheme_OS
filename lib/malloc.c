/* 
 * malloc.c --- short description
 * 
 * Copyright  (C)  2005  Fung Tse <WiKeithTse@163.com>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Fung Tse <WiKeithTse@163.com>
 * Maintainer: Fung Tse <WiKeithTse@163.com>
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

#include <stdlib.h>

#include <stdio.h>

#include <kscm/mm.h>
#include <kscm/config.h>
#include <asm/page.h>

typedef union Header {
	struct {
		size_t size;
		union Header *next;
		char block[0];
	};
	int64_t x;			/* Align */
} fm_header_t;

#ifdef TEST_STDLIB
size_t tst_get_fm_header_size(void *ptr)
{
	ptr -= sizeof(fm_header_t);
	return ((fm_header_t *)ptr)->size;
}

void *tst_get_fm_header_next(void *ptr)
{
	ptr -= sizeof(fm_header_t);
	return ((fm_header_t *)ptr)->next;
}

void *tst_get_fm_header_block(void *ptr)
{
	ptr -= sizeof(fm_header_t);
	return ((fm_header_t *)ptr)->block;
}

#endif	/* TEST_STDLIB */

static size_t _g_free_mem_unit;	/* no used */
static fm_header_t *_g_free_mem_list = (fm_header_t *)NULL;

void kscm_init_heap()
{
	/* fm_header_t *fst_entry = _g_free_mem_list + 1; */

	/* unused */
	_g_free_mem_unit = (K_PG_SIZE - 1) / sizeof(fm_header_t) - 1;

	_g_free_mem_list = (fm_header_t *)K_HEAP_START;
	
	_g_free_mem_list->size = (K_PG_SIZE - 1) / sizeof(fm_header_t) + 1;
	_g_free_mem_list->next = _g_free_mem_list;
}

#define __split_mem_blk(ap, size) ((fm_header_t *)	\
	(ap->size -= size + sizeof(fm_header_t),	\
	 (char *)ap + sizeof(fm_header_t) + ap->size))

static inline fm_header_t *__compact_memory()
{
	return NULL;		/* fail to compact memory */
}

void *kmalloc(size_t nbytes)
{
	fm_header_t *p, *q, *ptr;
	size_t nunits;

	
	nunits = (nbytes + sizeof(fm_header_t) - 1) / sizeof(fm_header_t) + 1;
	
	if (_g_free_mem_list == NULL) {
		_g_free_mem_list = (fm_header_t *)expand_region(mm_heap);
		_g_free_mem_list->size = (K_PG_SIZE - 1) / sizeof(fm_header_t) + 1;
		_g_free_mem_list->next = _g_free_mem_list;
	}
	q = _g_free_mem_list;

	for (p = q->next; ; q = p, p = p->next) {
		if (p->size >= nunits) {
			if (p->size == nunits) {
				q->next = p->next;
				if (q == p) /* last slot */
					_g_free_mem_list = NULL;
			}
			else {
				p->size -= nunits;
				p += p->size;
				p->size = nunits;
			}

			return (void *)(p + 1);
		}

		/* increase data region */
		if (p == _g_free_mem_list) {
			if ((ptr = (fm_header_t *)expand_region(mm_heap)) == NULL)
				break;
			
			q->next = ptr;
			ptr->size = (K_PG_SIZE - 1) / sizeof(fm_header_t) + 1;
			ptr->next = p;
		}
	}

	return NULL;
}

void kfree(void *ptr)
{
	fm_header_t *bp, *p;

	bp = (fm_header_t *)ptr - 1;

	for (p = _g_free_mem_list; !(bp > p && bp < p->next); p = p->next)
		if (p >= p->next && (bp > p || bp < p->next))
			break;
	
	if (p + p->size == bp) {
		p->size += bp->size;
		bp = p;
	}
	else
		p->next = bp;

	if (bp + bp->size == p->next) {
		bp->size += p->next->size;
		bp->next = p->next->next;
	}
	else
		bp->next = p->next;
}

/* most general purposed algorithm for allocating memory */
void *alloc_memory()
{
	
}
