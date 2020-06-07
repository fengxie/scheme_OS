/* 
 * arch.h --- short description
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

#ifndef ARCH_H
#define ARCH_H

#ifndef TEST_SCHEME
#include <asm/system.h>
#include <sys/types.h>
#endif

#include <scheme.h>

enum Scheme_arch_types {
	/* arch specifid types */
	_scheme_arch_type_ = scheme_undefined_type + 1,
	scheme_int32_type,
	scheme_ptr_type,
};

/* Special type to describe arch specified type */
#define SCHEME_INT32P(obj) SCHEME_INTP(obj)
#define SCHEME_INT32_VAL(obj) SCHEME_INT_VAL(obj)
#define SCHEME_SET_INT32(obj, v) SCHEME_SET_INT(obj, (long)v)

#define SCHEME_PTRP(obj) SCHEME_INTP(obj)
#define SCHEME_PTR_VAL(obj) ((void *)SCHEME_INT_VAL(obj))
#define SCHEME_SET_PTR(obj, v) SCHEME_SET_INT(obj, (long)v)

#include "numb.h"
#define scheme_make_int32(v) scheme_make_integer_numb((int)v)
#define scheme_make_ptr(ptr) scheme_make_integer_numb((int)ptr)

#endif
