/* 
 * vector.c --- short description
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


#include "vector.h"

#include "scheme.h"
#include "salloc.h"
#include "display.h"

/* locals */
DEFUN_LOCAL(vector_p);
DEFUN_LOCAL(make_vector);
DEFUN_LOCAL(vector);
DEFUN_LOCAL(vector_length);
DEFUN_LOCAL(vector_ref);
DEFUN_LOCAL(vector_set);
DEFUN_LOCAL(vector_to_list);
DEFUN_LOCAL(list_to_vector);
DEFUN_LOCAL(vector_fill);

void scheme_init_vector(Scheme_env_t *env)
{
	
}

Scheme_obj_t *scheme_make_vector(int size, Scheme_obj_t *fill)
{
	Scheme_obj_t *vector, **blk;

	vector = scheme_alloc_obj();
	blk = (Scheme_obj_t **)scheme_alloc(size * sizeof(Scheme_obj_t *));
	SCHEME_SET_TYPE(vector, scheme_vector_type);
	SCHEME_SET_VECTOR_BUF(vector, blk);
	SCHEME_SET_VECTOR_LEN(vector, size);
	while (size > 0) {
		*blk++ = fill++;
		size--;
	}

	return vector;
}

int scheme_vector_to_string(char *buf, Scheme_obj_t *vector)
{
	int size;
	char *__des = buf;
	Scheme_obj_t **p;
	
	*__des++ = '#';
	*__des++ = '(';
	for (p = SCHEME_VECTOR_BUF(vector), size = SCHEME_VECTOR_LEN(vector);
	     size > 0; size--, p++) {
		if (SCHEME_VECTORP(*p))
			__des += scheme_vector_to_string(__des, *p);
		else
			__des += scheme_obj_to_string(__des, *p);
		*__des++ = ' ';
	}
	*(__des - 1) = ')';
	*__des = '\0';

	return __des - buf;
}

DEFUN_LOCAL(vector_p)
{
	
}

DEFUN_LOCAL(make_vector)
{
	
}

DEFUN_LOCAL(vector)
{
	
}

DEFUN_LOCAL(vector_length)
{
	
}

DEFUN_LOCAL(vector_ref)
{
	
}

DEFUN_LOCAL(vector_set)
{
	
}

DEFUN_LOCAL(vector_to_list)
{
	
}

DEFUN_LOCAL(list_to_vector)
{
	
}

DEFUN_LOCAL(vector_fill)
{
	
}
