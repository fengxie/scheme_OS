/* 
 * hash.h --- short description
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

/* only used for symbol object */
#ifndef HASH_H
#define HASH_H

#include "scheme.h"

#define HTABLE_SIZE 1031

typedef int (*Scheme_compar_t)(void *, void *);

typedef struct Scheme_hash_table {
	struct _HtList {
		struct _HtList *next;
		void *key;
		Scheme_obj_t *val;
	} **ht;
	Scheme_compar_t eq_p;
} Scheme_htable_t;

void scheme_init_hash(Scheme_obj_t *env);
Scheme_htable_t *scheme_make_hash(Scheme_compar_t eq_p);
Scheme_obj_t *scheme_hash_get(Scheme_htable_t *ht, void *key);
int scheme_hash_put(Scheme_htable_t *ht, void *key, Scheme_obj_t *obj);

#endif
