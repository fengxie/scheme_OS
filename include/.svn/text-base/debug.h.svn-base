/* 
 * debug.h --- short description
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

#ifndef DEBUG_H
#define DEBUG_H

#include <kscm/config.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#ifdef KSCM_DEBUG_MSG_ON

#define DEBUG_MSG_FMT "%s:%d: In function `%s`: variable: "
#define DEBUG_MSG_PREFIX __FILE__, __LINE__, __FUNCTION__

#define debug_print_int(v) do {					\
		printf(DEBUG_MSG_FMT "%s = %d\n",		\
		       DEBUG_MSG_PREFIX, #v, (int)(v) );	\
	} while(0)

#define debug_print_addr(ptr) do {				\
		printf(DEBUG_MSG_FMT "%s = 0x%x\n",		\
		       DEBUG_MSG_PREFIX, #ptr,			\
		       (unsigned long)(ptr) );			\
	} while(0)

#else  /* KSCM_DEBUG_MSG_ON */

#define debug_print_int(v)

#endif	/* KSCM_DEBUG_MSG_ON */

#endif
