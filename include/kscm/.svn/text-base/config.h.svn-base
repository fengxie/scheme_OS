/* 
 * config.h --- short description
 * configurations for scheme os
 * 
 * Copyright  (C)  2005  Wizard' Tse <keith@localhost.localdomain>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Wizard' Tse <keith@localhost.localdomain>
 * Maintainer: Wizard' Tse <keith@localhost.localdomain>
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

#ifndef KSCM_CONFIG_H
#define KSCM_CONFIG_H

#define KBD_US

#define KSCM_GDT G_gdt
#define KSCM_IDT G_idt
#define KSCM_PAGE_DIR G_page_dir

#define DEF_INITSEG     0x9000
#define DEF_SYSSEG      0x1000
#define DEF_SETUPSEG    0x9020
#define DEF_SYSSIZE     0x4000

#define SYSSIZE		0x4000
#define SYSLEN		0x200
#define SETUPLEN	1
#define BOOTSEG		0x7c0
#define INITSEG		0x9000
#define SETUPSEG	0x9020
#define SYSSEG		0x1000
#define ENDSEG	        SYSSEG + SYSSIZE

/* system data */
#define EXTEND_MEMORY   (unsigned long)(*(unsigned short *)0x90002)

#define LOW_MEM		0x800000
#define TOTAL_MEMORY	0x80000000

#define PAGE_SIZE	(4 * 1024)
#define LARGE_PAGE_SIZE 0x400000

#define PGDIR_PADDR	(0x400000)

#define K_PG_SIZE	PAGE_SIZE
#define K_CODE_SIZE	LARGE_PAGE_SIZE

#define K_TEXT_START	(0x0)

#define K_HEAP_START	((void *)LOW_MEM)
#define K_HEAP_SIZE	0x500000	/* heap size */

#define K_STACK_SIZE	0x500000
#define K_STACK_BASE	(0x40000000 - LARGE_PAGE_SIZE)
#define K_STACK_START	((void *)K_STACK_BASE - K_PG_SIZE)

#define K_SLOTS_START	((void *)0x40000000)
#define K_SLOTS_SIZE	(0x20000000)

#define MAX_EVAL_STACK_SIZE (0x100000 / sizeof(void *))

/* If we're not using GNU C, elide __attribute__ */
#ifndef __GNUC__
#  define  __attribute__(x)  /*NOTHING*/
#endif

#define LISPM_MEM_BASE 0x40000000 /* start at 1G */
/* to restrict address range */
#define LISPM_MEM_ADDR_MASK 0x03ffffff
#define LISPM_MEM_OFF_BITS 22
#define LISPM_MEM_SIZE 0x40000000 /* 1G size */
#define LISPM_MEM_PAGE_SIZE 0x400000 /* 4m bytes page */

#define IA32_MTRR_FIX64K_00000 0x250
#define IA32_MTRR_FIX16K_80000 0x258
#define IA32_MTRR_FIX16K_A0000 0x259
#define IA32_MTRR_FIX4K_C0000 0x268
#define IA32_MTRR_FIX4K_C8000 0x269
#define IA32_MTRR_FIX4K_D0000 0x26a
#define IA32_MTRR_FIX4K_D8000 0x26b
#define IA32_MTRR_FIX4K_E0000 0x26c
#define IA32_MTRR_FIX4K_E8000 0x26d
#define IA32_MTRR_FIX4K_F0000 0x26e
#define IA32_MTRR_FIX4K_F8000 0x26f

#define KSCM_DEBUG_MSG_ON

#endif
