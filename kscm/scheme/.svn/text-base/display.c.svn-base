/* 
 * display.c --- short description
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

#include "display.h"

#include "list.h"
#include "vector.h"
#include "sstring.h"

#include <stdio.h>
#include <string.h>

int scheme_obj_to_string(char *buf, Scheme_obj_t *obj)
{
	int cnt = 0;
	
	if (SCHEME_CHARP(obj)) {
		buf[0] = '#';
		buf[1] = '\\';
		if (SCHEME_CHAR_VAL(obj) == ' ') {
			strcpy(buf + 2, "space");
			cnt = 7;
		}
		else if (SCHEME_CHAR_VAL(obj) == '\n') {
			strcpy(buf + 2, "newline");
			cnt = 9;
		}
		else {
			buf[2] = SCHEME_CHAR_VAL(obj);
			buf[3] = '\0';
			cnt = 3;
		}

		return cnt;
	}
	switch (SCHEME_TYPE(obj)) {
	case scheme_env_type:
		cnt = sprintf(buf, "#<environment 0x%x>",
			      (unsigned)SCHEME_ENV(obj));
		break;
	case scheme_prim_proc_type:
		cnt = sprintf(buf, "#<builtin 0x%x>",
			      (unsigned)SCHEME_PRIM_FUN(obj));
		break;
	case scheme_cpd_proc_type:
		cnt = sprintf(buf, "#<procedure 0x%x>",
			      (unsigned)SCHEME_PROC_BODY(obj));
		break;
	case scheme_integer_type:
		cnt = sprintf(buf, "%d", SCHEME_INT_VAL(obj));
		break;
	case scheme_string_type:
		*buf++ = '\"';
		strcpy(buf, SCHEME_STR_VAL(obj));
		cnt = strlen(buf);
		buf += cnt;
		*buf++ = '\"';
		*buf++ = '\0';
		cnt += 2;
		break;
	case scheme_symbol_type:
		strcpy(buf, SCHEME_SYMBOL_VAL(obj));
		cnt = strlen(buf);
		break;
	case scheme_null_type:
		strcpy(buf, "()");
		cnt = 2;
		break;
	case scheme_pair_type:
		cnt = scheme_list_to_string(buf, obj);
		break;
	case scheme_vector_type:
		cnt = scheme_vector_to_string(buf, obj);
		break;
	case scheme_input_port_type:
		strcpy(buf, "#[port i]");
		break;
	case scheme_output_port_type:
		strcpy(buf, "#[port o]");
		break;
	case scheme_bool_type:
		if (SCHEME_TRUEP(obj))
			strcpy(buf, "#t");
		else
			strcpy(buf, "#f");
		cnt = 2;
		break;
	case scheme_void_type:
		break;
	case scheme_undefined_type:
		break;
	default:		/* unknown type */
		break;
	}

	return cnt;
}
