/* 
 * stdlib.h --- short description
 * some usefull functions
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


#ifndef STDLIB_H
#define STDLIB_H

#include <sys/types.h>

char *_itoaU(unsigned int numb, char *buf, int radix);

#define malloc(size) kmalloc(size)
#define free(ptr) kfree(ptr)

extern void kscm_init_heap();
extern void *kmalloc(size_t size);
extern void kfree(void *ptr);

typedef struct mm_header {
	struct mm_header *next;
	size_t size;
} mHeader_t;

extern long int strtol(const char *nptr, char **endptr, int base);

extern int atoi(const char *nptr);
extern long int atol(const char *nptr);

#ifdef TEST_STDLIB
extern size_t tst_get_fm_header_size(void *ptr);
extern void *tst_get_fm_header_next(void *ptr);
extern void *tst_get_fm_header_block(void *ptr);
#endif	/* TEST_STDLIB */

#include <errno.h>

#endif
