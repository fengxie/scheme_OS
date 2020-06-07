/* 
 * port.h --- short description
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

#ifndef PORT_H
#define PORT_H

#include "scheme.h"

void scheme_init_port(Scheme_env_t *env);

Scheme_obj_t *scheme_make_char_input_stream(const char *buf);

int scheme_port_eof_p(Scheme_obj_t *port);
char scheme_port_peek_char(Scheme_obj_t *port);
char scheme_port_get_char(Scheme_obj_t *port);
int scheme_port_get_string(Scheme_obj_t *port, char *buf, int size);

extern Scheme_obj_t *scheme_current_input_port;
extern Scheme_obj_t *scheme_current_output_port;

#endif	/* PORT_H */
