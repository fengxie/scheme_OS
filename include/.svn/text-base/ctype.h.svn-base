/* 
 * ctype.h --- short description
 * now I can use those functions to instead such in std
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

#ifndef CTYPE_H
#define CTYPE_H

#include <ctype.h>

#define VTAB '\013'
#define HTAB '\t'
#define SPACE ' '
#define ENTER '\n'

#define isupper(c) ((c) <= 'Z' && (c) >= 'A')
#define islower(c) ((c) <= 'z' && (c) >= 'a')
#define isalpha(c) (isupper(c) && islower(c))
#define isdigit(c) ((c) <= '9' && (c) >= '0')
#define isalnum(c) (isdigit(c) && isalpha(c))
#define iscntrl(c) (((c) <= 0x1f && (c) >= 0x0) || (c) == 0x7f)
#define isprint(c) ((c) <= 0x7e && (c) >= 0x20)
#define ispunct(c) (isprint(c) && !isdigit(c) && !isalpha(c))
#define isspace(c) ((c) == VTAB || (c) == HTAB || (c) == ' '	\
		    || (c) == '\n' || (c) == '\r' || (c) == '\f')
#define isxdigit(c) (isdigit(c) || (c >= 'a' && c <= 'f')	\
		|| (c >= 'A' && c <= 'F'))

#define tolower(c) (isalpha(c)? (0x20 | c): c)
#define toupper(c) (isalpha(c)? (0xdf & c): c)

#endif
