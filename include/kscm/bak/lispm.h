/* 
 * lispm.h --- short description
 * for lisp machine
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

/* Now I can begin work for lisp machine */

#ifndef LISPM_H
#define LISPM_H

#include <sys/types.h>

enum {
	/* 0x0 -- 0x3f for regular type*/
	LISPM_PAIR = 0,
	LISPM_SYMBOL,
	LISPM_STRING,
	LISPM_VECTOR,

	LISPM_PRIMITIVE_PROC,
	/* implement as a `pair' */
	LISPM_COMPONENT_PROC,

	/* 6-7 bits are for `boolean' type */
	LISPM_BOOL = 0x0080,
	LISPM_BOOL_TRUE = 0x00c0,
	LISPM_BOOL_FALSE = 0x0080,

	/* 9bit indicates `char' type*/
	LISPM_CHAR = 0x0100,
	/* 0x0100 -- 0x01ff are used for `char' */

	/* 10bit is reserved */

	/* use 5 bits to implement subtype tower */
	LISPM_NUMBER = 0x8000,
	LISPM_COMPLEX = 0xc000,
	LISPM_REAL = 0xe000,
	LISPM_RATIONAL = 0xf400,
	/* do not support big number */
	LISPM_INTEGER = 0xfc00,	/* indicate that integer is exact */
	/* set 11bit to 1 indicate a exact number */
	LISPM_EXACT = 0x0400,
};
typedef unsigned short lispm_objtype_t;

typedef char *lispm_pmref_t;	/* reference to physic memory */

/* refer to a object in lisp machine's memory */
typedef unsigned int lispm_addr_t;

typedef long long lispm_int_t;

typedef union lispm_obj *lispm_obj_t;
typedef union lispm_obj {
	struct {
		int64_t x;
		int64_t y;
	} Align;			/* align to 16 bits boundary */
	
	struct {
		struct lisp_obj_header {
			lispm_objtype_t type __attribute__((aligned (2)));
			unsigned short tag __attribute__((aligned (2))); /* for gc */
		} head;
		union {
			struct {
				lispm_addr_t car;
				lispm_addr_t cdr;
			} pair;
			struct {
				lispm_pmref_t str;
				int32_t hkey; /* hash table */
				/* this field can be used to save binding for symbol */
			} symb;
			struct {
				lispm_addr_t body;
				lispm_addr_t args;
				lispm_addr_t env;
			} proc;
			struct {
				size_t size;
				lispm_addr_t base;
			} vector;
			struct {
				lispm_pmref_t str;
			} string;
#ifdef WITHOUT_LONG_LONG
			struct {
				unsigned long lbit;
				unsigned long hbit;
			} integer;
#else
			lispm_int_t integer;
#endif		/* WITHOUT_LONG_LONG */
		} body;
	};
} lispm_obj;

/* describe a lisp machine */
typedef struct LISPM {
	int32_t flags;		/* indicate the state of lisp machine */
	lispm_obj *fst_mem;	/* current memory */
	lispm_obj *snd_mem;	/* help for gc */

	/* global environment */
	/* current environment */
	/* core interpreter(CPU) */
} lispm, *lispm_t;

extern lispm G_lisp_machine;
/* get global current memory of lisp machine */
#define LISPM_MEM() (G_lisp_machine.fst_mem)
/* addr of lisp machine memory -> addr of real memory */
#define LISPM_MAP_PMEM(addr) (LISPM_MEM() + addr)

/*
 *  accessors (<accessor> <base> <lispm_addr_t>)
 */
#define LISPM_TYPE(obj) ((obj).head.type)
#define LISPM_TAG(obj) ((obj).head.tag)

/* :: (lispm_pair addr) => addr -> lispm_addr */
#define LISPM_PAIR_CAR(obj) ((obj).body.pair.car)
#define LISPM_PAIR_CDR(obj) ((obj).body.pair.cdr)

#define LISPM_STRING_PSTR(obj) ((obj).body.string.str)

/* :: (lispm_char addr) => addr -> char */
#define LISPM_CHAR_PCHAR(obj)
#define LISPM_CHAR_CHAR(obj) LISPM_TYPE(obj)

#define LISPM_ASCII_TO_CHAR(ch) (LISPM_CHAR + ch)

#define LISPM_BOOL_LVAL(obj) ((obj).head.type)

#define LISPM_SYMBOL_STR(obj) ((obj).body.symb.str)
#define LISPM_NUMBER_INT(obj) ((obj).body.integer)

#endif
