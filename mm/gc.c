/* 
 * gc.c --- short description
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

#include <kscm/gc.h>
#include <kscm/config.h>

#include <sys/types.h>

#include <kscm/mm.h>

static size_t _gc_slot_size;
static size_t _gc_free_nslots;
static void *_gc_next_slot;

void kscm_init_gc(size_t slot_size)
{
	_gc_slot_size = slot_size;
	_gc_free_nslots = K_PG_SIZE / slot_size;
	_gc_next_slot = K_SLOTS_START;
}

GC_obj_t *gc_alloc_obj()
{
	GC_obj_t *ptr;

	if (_gc_free_nslots < 1) {
		_gc_next_slot = expand_region(mm_slots);
		_gc_free_nslots += K_PG_SIZE / _gc_slot_size;
	}

	ptr = _gc_next_slot;
	_gc_next_slot += _gc_slot_size;
	_gc_free_nslots--;

	return ptr;
}

GC_obj_t *gc_alloc_nobj(int n)
{
	GC_obj_t *ptr;

	if (_gc_free_nslots < n) {
		expand_region(mm_slots);
		_gc_free_nslots += K_PG_SIZE / _gc_slot_size;
	}
	
	ptr = _gc_next_slot;
	_gc_next_slot += n * _gc_slot_size;
	_gc_free_nslots -= n;

	return ptr;
}

void gc_free_obj(GC_obj_t *obj)
{
	/* forbidden */
}

void gc_collect_garbage()
{
	
}
