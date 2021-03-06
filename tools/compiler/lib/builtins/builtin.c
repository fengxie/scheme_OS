/* 
 * builtin.c --- short description
 * 
 * Copyright  (C)  2006  Fung Tse <wikeithtse@gmail.com>
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

#include <config.h>

#include <builtin.h>
#include <svm.h>
#include <scheme.h>

#include <debug.h>

/* (+ a1 a2 a3 ...) */
void builtin_add()
{
	int argc = g_svm.reg_argc;
	
	if (argc == 0)
		leave_builtin(SCHEME_INT_ZERO);

	while (argc > 1) {
		argc--;
		g_svm.stack_top[argc - 1] = (Scheme_Obj_t *)
			((int)g_svm.stack_top[argc - 1] +
			 (int)g_svm.stack_top[argc]);
	}

	g_svm.stack_top[0] = (Scheme_Obj_t *)
		(((int)g_svm.stack_top[0] - svm_register(argc)) | 0x1);
	
	g_svm.reg_value = g_svm.stack_top[0];
	g_svm.stack_top += svm_register(argc);
}

/* (display #<scheme object>) */
void builtin_display()
{
	/* Scheme_Obj_t *ptr; */

	switch (SCHEME_TYPE(svm_register(value))) {
	case Scheme_Int_Type:
		printf("#VALUE = %d\n", SCHEME_OBJ_TO_INT(svm_register(value)));
		break;
	default:
		break;
	}
}
