/* 
 * proc.h --- short description
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

#ifndef PROC_H
#define PROC_H

#include "scheme.h"

Scheme_obj_t *scheme_apply(Scheme_obj_t *proc, Scheme_obj_t *pars);
Scheme_obj_t *scheme_make_prim_proc(Scheme_local_func_t fun, int mina, int maxa);
Scheme_obj_t *scheme_apply_prim_proc(Scheme_obj_t *prim_proc, Scheme_obj_t *arg);

Scheme_obj_t *scheme_make_procedure(Scheme_obj_t *vars,Scheme_obj_t *body, Scheme_env_t *env);

extern Scheme_obj_t scheme_void[1]; /* the void constant */

#endif
