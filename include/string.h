/* 
 * string.h --- short description
 * operations for string
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

#ifndef STRING_H
#define STRING_H

#include <sys/types.h>

#include <ctype.h>

static inline void *memcpy(void *dest, const void *src, size_t n)
{
	void *__res = dest;
	
	__asm__ volatile (
		"push %%esi\n\t"
		"push %%edi\n\t"
		"cld\n\t"
		"rep\n\t"
		"movsb\n\t"
		"pop %%edi\n\t"
		"pop %%esi\n\t"
		:
		: "D" ((long)__res), "S" ((long)src), "c" ((long)n)
		: "memory");
	
	return __res;
}

extern void *memset(void *s, int c, size_t n);

static inline void *memmove(void *dest, const void *src, size_t n)
{
	if (dest > src && dest - src < n) {
		memcpy(dest + (dest - src), dest, n - (dest - src));
		n = dest - src;
	}
	/* copy rest */
	return memcpy(dest, src, n);
}

static inline char *strcpy(char *dest, const char *src)
{
	char *p = (char *)src, *q = dest;
	
	while ((*q++ = *p++) != '\0')
		;

	return dest;
}

static inline int strlen(const char *str)
{
	int __cnt = 0;
	
	while (*str++)
		__cnt++;
	
	return __cnt;
}

static inline char *strncpy(char *dest, const char *src, size_t n)
{
	char *p = (char *)src;

	while (n-- > 0 && (*dest++ = *p++) != 0)
		;

	*dest = '\0';
	
	return dest;
}

static inline int strcmp(const char *s1, const char *s2)
{
	int __res = 0;

	while (*s1 != '\0' && *s2 != '\0'
	       && (__res = *s1++ - *s2++) == 0)
		;
	
	return __res;
}

static inline int strcasecmp(const char *s1, const char *s2)
{
	int __res = 0;

	while (*s1 != '\0' && *s2 != '\0'
	       && (__res = tolower(*s1) - tolower(*s2)) == 0) {
		s1++;
		s2++;
	}
	
	return __res;
}

static inline void *strcat(char *dest, const char *src)
{
	while (*dest)
		dest++;

	return strcpy(dest, src);
}

#endif
