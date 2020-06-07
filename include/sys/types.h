/* 
 * types.h --- short description
 * 
 * Copyright  (C)  2005  Wizard' Tse <keith@gmail.com>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Wizard' Tse <keith@gmail.com>
 * Maintainer: Wizard' Tse <keith@gmail.com>
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

#ifndef SYS_TYPES_H
#define SYS_TYPES_H

#ifndef SIZE_T
#define SIZE_T
typedef unsigned int size_t;
#endif

#ifndef TIME_T
#define TIME_T
typedef long time_t;
#endif

#ifndef PTRDIFF_T
#define PTRDIFF_T
typedef long ptrdiff_t;
#endif

#ifndef NULL
#define NULL ((void *) 0)
#endif

#ifndef EOF
#define EOF (-1)
#endif

typedef enum {
	FALSE = 0,
	TRUE,
} _bool;

/* These types are defined by the ISO C99 header <inttypes.h>. */
#ifndef __int8_t_defined
#define __int8_t_defined
typedef	unsigned char int8_t;
typedef	unsigned short int16_t;
typedef	unsigned int int32_t;
typedef unsigned long long int64_t;
#endif	 /* __int8_t_defined */

/* round array to align 4bit boundary */
#define array_rounded_size(nunits, type)				\
	((((sizeof(type) * nunits) + sizeof(int) - 1) / sizeof(int)) * sizeof(int))
#define DEF_ARRAY(name, size, type) ()

#endif	/* SYS_TYPES_H */
