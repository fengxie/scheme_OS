/* 
 * scheme.c --- short description
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

#include "scheme.h"

#include "env.h"
#include "read.h"
#include "port.h"
#include "bool.h"
#include "numb.h"
#include "sstring.h"
#include "list.h"

#include "eval.h"
#include "display.h"

void scheme_init()
{
	Scheme_env_t *env;
	
	scheme_init_env(NULL_ENV);
	env = scheme_global_environment;
	scheme_init_read(env);
	scheme_init_port(env);
	scheme_init_bool(env);
	scheme_init_number(env);
	scheme_init_string(env);
	scheme_init_list(env);
	
}

int scheme_driven_loop(int argc, Scheme_obj_t *argv[])
{
	
}
