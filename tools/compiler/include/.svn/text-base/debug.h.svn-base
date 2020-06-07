/* 
 * debug.h --- short description
 * 
 * Copyright  (C)  2006  Fung Tse <WiKeithTse@163.com>
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

#ifndef DEBUG_H
#define DEBUG_H

#define print_vm_st() do {			\
		;				\
	} while(0)

#ifndef NDEBUG

#include <stdio.h>
#include <stdlib.h>

#define print_obj_addr(obj) do {					\
		printf(__FILE__ ": In function `" "\'\n");	\
		printf(__FILE__ ": %d: `" #obj "\' = 0x%x\n",	\
		       __LINE__, (unsigned int)(obj));		\
	} while(0)

#else

#define print_obj_addr(obj)

#endif	/* NDEBUG */

#endif
