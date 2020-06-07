/* 
 * svm.c --- short description
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


#include <svm.h>
#include <gc.h>

#include <stdio.h>
#include <stdlib.h>

Scheme_VM_t g_svm;

int svm_init(Scheme_Envt_t *envt, Scheme_Obj_t **stack_start, int stack_size)
{
	int i;
	
	g_svm.reg_value = NULL;
	g_svm.reg_cont = NULL;
	g_svm.reg_template = NULL;
	g_svm.reg_pc = NULL;
	LOAD_ENVT(envt);

	for (i = 0; i < 32; i++) {
		g_svm.reg_temp[i] = NULL;
	}
	g_svm.stack_start = stack_start;
	g_svm.stack_size = stack_size;
	g_svm.stack_base = g_svm.stack_top = stack_start + stack_size;

	return 0;
}

/* size will be pass by g_svm.reg_argc */
void alloc_c_obj()
{
	g_svm.c_ptr = malloc(g_svm.reg_argc);
}

void print_vm_state()
{
	fprintf(stderr, "---Scheme Virtual Machine status---\n");
	fprintf(stderr, "Registers:");
	fprintf(stderr, "$value: 0x%x\n", (unsigned int)g_svm.reg_value);
	fprintf(stderr, "$envt: 0x%x\n", (unsigned int)g_svm.reg_envt);
	fprintf(stderr, "$cont: 0x%x\n", (unsigned int)g_svm.reg_cont);
	fprintf(stderr, "$template: 0x%x\n", (unsigned int)g_svm.reg_template);
	fprintf(stderr, "$pc: <does not support now!>\n");
}
