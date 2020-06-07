/* 
 * arch.c --- short description
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

#include "arch.h"

#include "scheme.h"

#ifndef TEST_SCHEME
#include <asm/system.h>
#include <kscm/mm.h>
#endif	/* TEST_SCHEME */

/* locals */
SCHEME_DEFUN(cpu_info, argc, argv);

/* raw port I/O */
SCHEME_DEFUN(write_portb, argc, argv);
SCHEME_DEFUN(read_portb, argc, argv);
SCHEME_DEFUN(set_memb, argc, argv);
SCHEME_DEFUN(get_memb, argc, argv);
SCHEME_DEFUN(set_memw, argc, argv);
SCHEME_DEFUN(get_memw, argc, argv);
SCHEME_DEFUN(set_memd, argc, argv);
SCHEME_DEFUN(get_memd, argc, argv);
SCHEME_DEFUN(mem_map, argc, argv);

void scheme_init_arch(Scheme_env_t *env)
{
	
}

/*
 * (cpu-info '<mode>) -> <value>
 * (cpu-info) ->
 * ((processor . 0)
 *  (vendor_id . "GenuineIntel")
 *  (family    . 15)
 *  (model     . 2)
 *  (model-name  . "Intel(R) Pentium(R) 4 CPU 1.60GHz")
 *  (stepping    . 4)
 *  (cpu-MHz     . 1996.816)
 *  (cache-size  . 512)
 *  (fdiv_bug    . no)
 *  (hlt_bug     . no)
 *  (f00f_bug    . no)
 *  (coma_bug    . no)
 *  (fpu         . yes)
 *  (fpu_exception . yes)
 *  (cpuid level   . 2)
 *  (wp            . yes)
 *  (flags fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmovpat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm)
 *  (bogomips      . 3996.80))
 */
SCHEME_DEFUN(cpu_info, argc, argv)
{
	
}

/* raw port I/O */
/* (write-portb! <port> <byte>) -> scheme_void */
SCHEME_DEFUN(write_portb, argc, argv)
{
#ifndef TEST_SCHEME
	short port = 0xffff & SCHEME_INT_VAL(argv[0]);
	outb(port, SCHEME_CHAR_VAL(argv[1]));
	return scheme_void;
#endif
}

/* (read-portb <port>) -> byte*/
SCHEME_DEFUN(read_portb, argc, argv)
{
#ifndef TEST_SCHEME
	short port = 0xffff & SCHEME_INT_VAL(argv[0]);
	return SCHEME_CHAR_TO_OBJ(inb(port));
#endif
}

SCHEME_DEFUN(set_memb, argc, argv)
{
	
}

SCHEME_DEFUN(get_memb, argc, argv)
{
	
}

SCHEME_DEFUN(set_memw, argc, argv)
{
	
}

SCHEME_DEFUN(get_memw, argc, argv)
{
	
}

SCHEME_DEFUN(set_memd, argc, argv)
{
	
}

SCHEME_DEFUN(get_memd, argc, argv)
{
	
}

SCHEME_DEFUN(mem_map, argc, argv)
{
#ifndef TEST_SCHEME
	void *ptr = SCHEME_PTR_VAL(argv[0]);
	unsigned long page = SCHEME_INT32_VAL(argv[1]);

	return scheme_make_ptr(put_page(ptr, page));
#endif
}
