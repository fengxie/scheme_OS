/* 
 * page.h --- short description
 * data structure for paging
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

#ifndef SYS_PAGE_H
#define SYS_PAGE_H

#include <sys/types.h>

union pde {
	struct {
		unsigned present : 1;
		unsigned data : 31;
	} avl;
	struct {
		unsigned present : 1;
		unsigned rw : 1;
		unsigned us : 1;
		unsigned pwt : 1;
		unsigned pcd : 1;
		unsigned accessed : 1;
		unsigned rsv : 1;
		unsigned ps : 1;
		unsigned gpage : 1;
		unsigned avl : 3;
		unsigned base : 20;
	} pde;
	int32_t val;		/* facility for assign value from
				 * int32 */
} __attribute__((packed));

union pte {
	struct {
		unsigned present : 1;
		unsigned data : 31;
	} avl;
	struct {
		unsigned present : 1;
		unsigned rw : 1;
		unsigned us : 1;
		unsigned pwt : 1;
		unsigned pcd : 1;
		unsigned accessed : 1;
		unsigned dirty : 1;
		unsigned pat : 1;
		unsigned gpage : 1;
		unsigned avl : 3;
		unsigned base : 20;
	} pte;
	int32_t val;		/* facility for assign value from
				 * int32 */
} __attribute__((packed));

/* is present? */
#define page_present_p(page_table_entry) ((page_table_entry).pte.present)

#define invalidate() \
	__asm__("movl %%eax, %%cr3":: "a" (0))

typedef int32_t pde_t;
typedef int32_t pte_t;

typedef unsigned long physcial_addr_t;

/* linear address to pgdir */
#define PDT_IDX(addr) ((unsigned long)(addr) >> 22)
#define PGT_IDX(addr) (((unsigned long)(addr) >> 12) & 0x3ff)

#endif

