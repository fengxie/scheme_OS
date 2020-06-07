
#include <kscm/config.h>

#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define VIDEO_BASE_ADDR ((unsigned char*)0xb8000 + LARGE_PAGE_SIZE)

#define ORIG_X (*(unsigned char*)0x90000)
#define ORIG_Y (*(unsigned char*)0x90001)
#define ORIG_VIDEO_PAGE (*(unsigned short *)0x90004)
#define ORIG_VIDEO_MODE ((*(unsigned short *)0x90006) & 0xff)
#define ORIG_VIDEO_COLS (((*(unsigned short *)0x90006) & 0xff00) >> 8)
#define ORIG_VIDEO_LINES ((*(unsigned short *)0x9000e) & 0xff)
#define ORIG_VIDEO_EGA_AX (*(unsigned short *)0x90008)
#define ORIG_VIDEO_EGA_BX (*(unsigned short *)0x9000a)
#define ORIG_VIDEO_EGA_CX (*(unsigned short *)0x9000c)

#define VIDEO_TYPE_MDA 0x10
#define VIDEO_TYPE_CGA 0x11
#define VIDEO_TYPE_EGAM 0x20
#define VIDEO_TYPE_EGAC 0x21

struct video_unit {
	char ascii __attribute__((packed));
	char attr __attribute__((packed));
};
	
/* static inline void gotoxy(int currcons, int new_x,unsigned int new_y); */
static struct console {
	unsigned char cur_x;
	unsigned char cur_y;
	unsigned short cur_p;		/* cursor position in vbuff*/
	unsigned short cur_attr;	/* cursor attribute */
	unsigned short cols;
	unsigned short lines;
	unsigned short video_mode;
	unsigned short video_page;
	unsigned char  *pg_vbuff; /* video buff addr for current page */

	_bool init_flag;
} _g_con_attr = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, FALSE
};

static unsigned short _g_colored;
static unsigned char *_g_video_base_addr;

void console_init()
{
	if (_g_con_attr.init_flag == TRUE)
		return;

	if (ORIG_VIDEO_EGA_BX & 0xff00) {
		_g_colored = 0;
		_g_video_base_addr = (unsigned char*)0xb0000 + LARGE_PAGE_SIZE;
	}
	else {
		_g_colored = 1;
		_g_video_base_addr = (unsigned char*)0xb8000 + LARGE_PAGE_SIZE;
	}

	_g_con_attr.cur_x = ORIG_X;
	_g_con_attr.cur_y = ORIG_Y;
	_g_con_attr.cur_p = ORIG_Y * ORIG_VIDEO_COLS + ORIG_X;
	_g_con_attr.cols = ORIG_VIDEO_COLS;
	_g_con_attr.lines = 25;
	_g_con_attr.video_mode = ORIG_VIDEO_MODE;
	_g_con_attr.video_page = ORIG_VIDEO_PAGE;
	_g_con_attr.pg_vbuff = 
		(_g_video_base_addr + (_g_con_attr.video_page - 7) * 0x1000);

	_g_con_attr.init_flag = TRUE;
}

void scroll_down(int lines)
{
	memmove(_g_con_attr.pg_vbuff,
		_g_con_attr.pg_vbuff + _g_con_attr.cols * lines * 2,
		(size_t)0x1000);
	_g_con_attr.cur_y -= lines;
	_g_con_attr.cur_p -= lines * _g_con_attr.cols;
}

/* print message to screen */
int console_print(const char *buf)
{
	int ct = 0;
	struct video_unit vc, *vp;

	vp = (struct video_unit *)_g_con_attr.pg_vbuff +
		_g_con_attr.cur_y * _g_con_attr.cols +
		_g_con_attr.cur_x;
	vc.attr = 0x0f;
	while ((vc.ascii = *buf++) != '\0') {
	/* 
         * __asm__(
	 * 	"call print_reg32\n\t"
	 * 	"died_loop:\n\t"
	 * 	"jmp died_loop\n\t"
	 * 	:: "a"('0')
	 * 	);
         */

		switch (vc.ascii) {
		case '\0':
			__asm__ ("call print_reg32\n\t");
			break;
		case '\n':
			_g_con_attr.cur_y++;
			vp += _g_con_attr.cols - _g_con_attr.cur_x;
			_g_con_attr.cur_x = 0;
			break;
		case '\r':
			vp -= _g_con_attr.cur_x;
			_g_con_attr.cur_x = 0;
			break;
		default:	/* output char to screen */
			_g_con_attr.cur_x++;
			if (_g_con_attr.cur_x >= _g_con_attr.cols) {
				_g_con_attr.cur_x = 0;
				_g_con_attr.cur_y++;
			}
			*vp = vc;
			vp++;
			break;
		}

		if (_g_con_attr.cur_y >= _g_con_attr.lines) {
			scroll_down(1);
			vp -= _g_con_attr.cols;
		}

		ct++;
	}
	_g_con_attr.cur_p =
		_g_con_attr.cur_y * _g_con_attr.cols
		+ _g_con_attr.cur_x;
	
	return ct;
}
