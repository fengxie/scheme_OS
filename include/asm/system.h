/* 
 * system.h --- short description
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

#ifndef ASM_SYSTEM_H
#define ASM_SYSTEM_H

#include "io.h"

#define sti() __asm__ volatile ("sti\n\t")
#define cli() __asm__ volatile ("cli\n\t")
#define nop() __asm__ volatile ("nop\n\t")
#define iret() __asm__ volatile ("iret\n\t")

struct CR0 {
	unsigned pe : 1;
	unsigned mp : 1;
	unsigned em : 1;
	unsigned ts : 1;
	unsigned et : 1;
	unsigned ne : 1;
	unsigned reserved_1 : 10;
	unsigned wp : 1;
	unsigned reserved_2 : 1;
	unsigned am : 1;
	unsigned reserved_3 : 10;
	unsigned nw : 1;
	unsigned cd : 1;
	unsigned pg : 1;
} __attribute__((packed));

static inline void load_cr0(struct CR0 cr)
{
	__asm__ volatile (
		"movl %0, %%cr0\n\t"
		:
		: "a"(cr));
}

static inline void save_cr0(struct CR0 *cr)
{
	__asm__ volatile (
		"movl %%cr0, %%eax\n\t"
		: "=a" (*cr)
		: 
		: "memory");
}

struct CR1 {
	unsigned reserved_1 : 32;
} __attribute__((packed));

struct CR3 {
	unsigned reserved_1 : 3;
	unsigned pwt : 1;
	unsigned pcd : 1;
	unsigned reserved_2 : 7;
	unsigned page_dir_base : 20;
} __attribute__((packed));

static inline void load_cr3(struct CR3 cr)
{
	__asm__ volatile (
		"mov %0, %%cr3\n\t"
		:
		: "a"(cr));
}

static inline void save_cr3(struct CR3 *cr)
{
	__asm__ volatile (
		"mov %%cr3, %0\n\t"
		: "=a"(*cr)
		:
		: "memory");
}

struct CR4 {
	unsigned vme : 1;
	unsigned pvi : 1;
	unsigned tsd : 1;
	unsigned de : 1;
	unsigned pse : 1;
	unsigned pae : 1;
	unsigned mce : 1;
	unsigned pge : 1;
	unsigned pce : 1;
	unsigned osfxsr : 1;
	unsigned osxmmexcpt : 1;
	unsigned page_dir_base : 20;
} __attribute__((packed));

static inline void load_cr4(struct CR4 cr)
{
	__asm__ volatile (
		"mov %0, %%cr4\n\t"
		:
		: "a"(cr));
}

static inline void save_cr4(struct CR4 *cr)
{
	__asm__ volatile (
		"mov %%cr4, %0\n\t"
		: "=a"(*cr)
		:
		: "memory" );
}

static inline void enable_global_page()
{
	__asm__ volatile (
		"movl %%cr4, %%eax\n\t"
		"orl  $0x8, %%eax\n\t"
		"movl %%eax, %%cr4\n\t"
		);
}

#endif
