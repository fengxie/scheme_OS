/* 
 * lispm_mm.c --- short description
 * code for memory management of lisp machine
 * 
 * Copyright  (C)  2005  Wizard' Tse <keith@gmail.com>
 * 
 * Version: 1.0
 * Keywords: 
 * Author: Wizard' Tse <keith@gmail.com>
 * Maintainer: Wizard' Tse <keith@gmail.com>
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

#include <kscm/lispm.h>
#include <asm/page.h>

#include <stdlib.h>

static lispm_addr_t _g_lispm_ptr;

void lispm_minit()
{
	extern union pde *KSCM_PAGE_DIR;
	extern lispm_addr_t _g_lispm_ptr;

	_g_lispm_ptr = 0;
	
	/* the physic base address of lisp machine memory should gain
	 * through a uniform mechanism from module `mm'. But now I
	 * have not finish the mm yet, I could use a arbitrary address
	 * instead.  */
	KSCM_PAGE_DIR[LISPM_MEM_BASE >> LISPM_MEM_OFF_BITS].val
		= 0x0200119b;
}

/* allocate size * slots to hold lism_obj */
lispm_addr_t lispm_alloc(size_t numb)
{
	lispm_addr_t addr = _g_lispm_ptr;
	
	_g_lispm_ptr += numb;
	return addr;
}

/* no need for free(), this work will be taken by GC */
