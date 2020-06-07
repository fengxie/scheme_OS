/* 
 * port.c --- short description
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

#include "port.h"

#include "scheme.h"
#include "salloc.h"
#include "env.h"
#include "symbol.h"

#ifndef TEST_SCHEME
#include <asm/system.h>
#endif

#include <stdio.h>

/* globals */
Scheme_obj_t scheme_eof[1];

Scheme_obj_t *scheme_current_input_port;
Scheme_obj_t *scheme_current_output_port;

#ifndef TEST_SCHEME

/* locals */
/* this buffer should be move to the buffer module */
static char _line_buffer[1024];
static int _offset;

#endif

DEFUN_LOCAL(input_port_p);
DEFUN_LOCAL(output_port_p);
DEFUN_LOCAL(current_input_port);
DEFUN_LOCAL(current_output_port);
DEFUN_LOCAL(with_input_from_file);
DEFUN_LOCAL(with_output_to_file);
DEFUN_LOCAL(open_input_file);
DEFUN_LOCAL(open_output_file);
DEFUN_LOCAL(close_input_port);
DEFUN_LOCAL(close_output_port);

void scheme_init_port(Scheme_env_t *env)
{
	Scheme_obj_t *port;

#ifdef _KSCM_KERNEL
	_offset = 0;
	_line_buffer[0] = '\0';
	port = scheme_alloc_obj();
	SCHEME_SET_TYPE(port, scheme_input_port_type);
	SCHEME_SET_PORT_STREAM(port, scheme_null);
	SCHEME_SET_PORT_TAG(port, scheme_port_direct_input_type);
	scheme_current_input_port = port;

	scheme_register_primitive("input-port?", input_port_p, 1, 1, env);
	scheme_register_primitive("output-port?", output_port_p, 1, 1, env);
	scheme_register_primitive("current-input-port", current_input_port, 0, 0, env);
	scheme_register_primitive("current-output-port", current_output_port, 0, 0, env);
	scheme_register_primitive("with-input-from-file", with_input_from_file, 1, 1, env);
	scheme_register_primitive("with-output-to-file", with_output_to_file, 1, 1, env);
	scheme_register_primitive("open-input-file", open_input_file, 1, 1, env);
	scheme_register_primitive("open-output-file", open_output_file, 1, 1, env);
	scheme_register_primitive("close-input-port", close_input_port, 1, 1, env);
	scheme_register_primitive("close-output-port", close_output_port, 1, 1, env);
#endif	/* _KSCM_KERNEL */
	scheme_define_var(scheme_make_symbol("*scheme-current-input-port*"), port, env);
}

/* used as a interface for console and interpreter */
Scheme_obj_t *scheme_make_char_input_stream(const char *buf)
{
	Scheme_obj_t *stream;

	stream = scheme_alloc_obj();
	if (SCHEME_VOIDP(stream)) {
		/* exception: out of memory */
		/* ... */

		return scheme_void;
	}
	SCHEME_SET_TYPE(stream, scheme_input_port_type);
	SCHEME_SET_PORT_STREAM(stream, (char *)buf);
	SCHEME_SET_PORT_TAG(stream, scheme_port_char_stream_type);

	return stream;
}

DEFUN_LOCAL(input_port_p)
/* int argc, Scheme_obj_t *argv */
{
	return SCHEME_INPUT_PORTP(*argv)? scheme_true: scheme_false;
}

DEFUN_LOCAL(output_port_p)
{
	return SCHEME_OUTPUT_PORTP(*argv)? scheme_true: scheme_false;
}

DEFUN_LOCAL(current_input_port)
{
	return scheme_current_input_port;
}

DEFUN_LOCAL(current_output_port)
{
	return scheme_current_output_port;
}

DEFUN_LOCAL(with_input_from_file)
{
	
}

DEFUN_LOCAL(with_output_to_file)
{
	
}

DEFUN_LOCAL(open_input_file)
{
	
}

DEFUN_LOCAL(open_output_file)
{
	
}

DEFUN_LOCAL(close_input_port)
{
	
}

DEFUN_LOCAL(close_output_port)
{
	
}

char scheme_port_peek_char(Scheme_obj_t *port)
{
	char c;
	
	switch (SCHEME_PORT_TYPE(port)) {
	case scheme_port_char_stream_type:
		c = *((char *)SCHEME_PORT_STREAM(port) + (SCHEME_PORT_TAG(port) >> 1));
		if (c == '\0')
			return EOF; /* eof */
		break;
	case scheme_port_file_stream_type:
		break;
	case scheme_port_direct_input_type:
		break;
	default:
		/* exception: unknown type */
		break;
	}

	return c;
}

char scheme_port_get_char(Scheme_obj_t *port)
{
	extern char _line_buffer[];
	extern int _offset;
#ifdef _KSCM_KERNEL
	extern char key_map[];
	extern char shift_map[];
#endif	/* _KSCM_KERNEL */
	int tag;
	char c, v;
#ifdef _KSCM_KERNEL
	char *keymap = key_map;
#endif	/* _KSCM_KERNEL */

	switch (SCHEME_PORT_TYPE(port)) {
	case scheme_port_char_stream_type:
		c = *((char *)SCHEME_PORT_STREAM(port) + (SCHEME_PORT_TAG(port) >> 2));
		tag = SCHEME_PORT_TAG(port) + 0x4;
		SCHEME_SET_PORT_TAG(port, tag);
		if (c == '\0')
			return EOF; /* eof */
		break;
	case scheme_port_file_stream_type:
		break;
#ifdef _KSCM_KERNEL
	case scheme_port_direct_input_type:
		c = _line_buffer[_offset++];
		v = '\0';

		if (c == '\n') { /* end of line buffer */
			_offset = 0;
			_line_buffer[0] = '\0';
		}
		else if (c == '\0') {
			_offset = 0;
			do {
				while (!(inb(0x64) & 1))
					;
				if ((v = inb(0x60)) & 0x80) {
					/* up code */
					/* printf("up, 0x%x,", v); */
					
					if (v == (char)0xaa || v == (char)0xb6) {
						/* release shift */
						keymap = key_map;
					}
					
					continue;
				}
				/* printf("down 0x%x,", v); */
				if (v == 0x2a || v == 0x36) {
					keymap = shift_map;
					continue;
				}
				v = keymap[v];
				if (v == '\r') /* convert '\r' to '\n' */
					v = '\n';
				printf("%c", v);
				if (_offset >= 1024)
					/* bug: all characters that
					exceed th limit of line_buffer
					will be dicarded */
					continue;
				_line_buffer[_offset++] = v;
			} while(v != '\n');
			_offset = 0;
			c = _line_buffer[_offset++];
		}
		break;
#endif	/* _KSCM_KERNEL */
	default:
		/* exception: unknown type */
		break;
	}

	return c;
}

int scheme_port_get_string(Scheme_obj_t *port, char *buf, int size)
{
	int idx, cnt, tag;
	char *s, *t;

	cnt = 0;
	switch (SCHEME_PORT_TYPE(port)) {
	case scheme_port_char_stream_type:
		idx = SCHEME_PORT_TAG(port) >> 1;
		t = s = (char *)SCHEME_PORT_STREAM(port) + idx;
		while (size > 0 && (*buf++ = *s++) != '\0') {
			size--;
			cnt++;
		}
		if (s == (t + 1))
			return -1; /* eof */
		else {
			*buf = '\0';
			tag = SCHEME_PORT_TAG(port) + (cnt << 1);
			SCHEME_SET_PORT_TAG(port, tag);
		}
		break;
	case scheme_port_file_stream_type:
		break;
	default:
		/* exception: unknown type */
		break;
	}

	return cnt;
}
