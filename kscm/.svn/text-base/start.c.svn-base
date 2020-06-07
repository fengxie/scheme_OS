/* 
 * start.c --- short description
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

#include <kscm/config.h>
#include <asm/page.h>
#include <asm/system.h>
#include <kscm/mm.h>
#include <kscm/proc.h>

#include <debug.h>

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>
#include <string.h>

#include "scheme/scheme.h"
#include "scheme/read.h"
#include "scheme/env.h"
#include "scheme/display.h"
#include "scheme/port.h"
#include "scheme/eval.h"

extern char key_map[];

extern int console_print(const char *buf);
extern void console_init();
extern void scroll_down(int lines);

extern void *put_page(void *ptr, unsigned long page);
extern unsigned long get_free_frame(void);
extern void * get_bitmap_size();

struct Test {
	int t1, t2;
	char t3;
};

int main()
{
	extern unsigned long KSCM_PAGE_DIR;
	int type, i;
	char buf[1024], v;

	int *p, *q;
	unsigned long frame;
	union pde *page_dir = (union pde*)&KSCM_PAGE_DIR;
	struct Test *ptr;
	Scheme_obj_t *port, *exp;

	/* initialize system */
	console_init();
	printf("\nConsole initialized Ok!\n");
	kscm_init_proc();
	printf("Initialize paging... ");
	kscm_init_paging();
	printf("Ok\n");

	/* 
         * printf("Test memory alias... ");
	 * p = put_page(0x40000000, 0x1000000);
	 * q = put_page(0x40001000, 0x1000000);
	 * printf("0x%x Ok\n", q);
         */

	kscm_init_heap();

	printf("Initialize interpreter...");
	scheme_init();
	port = scheme_make_char_input_stream("(+ 1 2)");
	exp = scheme_read(port);
	scheme_obj_to_string(buf, exp);
	printf("object: %s\n", buf);
	exp = scheme_eval(exp, scheme_global_environment);
	scheme_obj_to_string(buf, exp);
	printf("value: %s\n", buf);
	printf("Ok\n");

	debug_print_int(i);
	debug_print_addr(exp);
	
	while (1) {
		printf("KSCM > ");
		exp = scheme_read(scheme_current_input_port);
		if (SCHEME_VOIDP(exp))
			printf("\n;Unspecified return value\n\n");
		else {
			exp = scheme_eval(exp, scheme_global_environment);
			scheme_obj_to_string(buf, exp);
			printf("\n;Value: %s\n\n", buf);
		}
	}
	
	return 0;
}
