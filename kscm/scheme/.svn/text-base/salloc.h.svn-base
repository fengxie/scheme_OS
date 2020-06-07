/* 
 * salloc.h --- short description
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
 *   allocate scheme object for scheme procedure
 * 
 * Code:
 */

#ifndef SALLOC_H
#define SALLOC_H

#include "scheme.h"

#include <stdlib.h>

#ifdef USE_GC

#define scheme_alloc(size) (malloc(size))
#define scheme_alloc_obj() (gc_alloc_obj())
#define scheme_alloc_vector(size) (gc_alloc_block(size))

#else

#define scheme_alloc_obj() ((Scheme_obj_t *)malloc(sizeof(Scheme_obj_t)))
#define scheme_free_obj(obj) (free(obj))

#define scheme_alloc(size) (malloc(size))
#define scheme_free(ptr) (free(ptr))

#define scheme_alloc_vector(size) ((Scheme_obj_t *)malloc(sizeof(Scheme_obj_t)*size))
#define scheme_free_vector(v) (free(v))

#endif	/* USE_GC */

#endif
