/* 
 * numb.h --- short description
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

#ifndef NUMB_H
#define NUMB_H

#include <builtin.h>

#ifdef __GNUC__

/* this can be done during compile time by type deducing if the type system
 * can be successfully introduced in this compiler in many case. */
/* this just a run time type checker with type :: a -> Bool  */
/* DEFINE_BUILTIN(number_p) */
/* DEFINE_BUILTIN(integer_p) */

DEFINE_BUILTIN(add)
DEFINE_BUILTIN(sub)

#else

void builtin_add();

/* ``argc'' must be a const */
#define M_builtin_add(argc) do {					\
		call_builtin(builtin_add, argc);			\
	} while (0)

#error Need GNUC to compile this program

#endif	/* __GNUC__ */

#endif
