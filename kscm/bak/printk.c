
#include <stdio.h>
#include <stdarg.h>

extern int console_print(const char *buf);

static char _g_print_buf[1024];

int sprintk(char *buf, const char *fmt, ...)
{
	int ct;
	va_list ap;

	va_start(ap, fmt);
	ct = vsprintf(buf, fmt, ap);
	va_end(ap);
	
	return ct;
}

/* a function that work just like printf */
int printk(const char *fmt, ...)
{
	int ct;
	va_list ap;
	
	va_start(ap, fmt);
	ct = vsprintf(_g_print_buf, fmt, ap);
	va_end(ap);

	console_print(_g_print_buf);

	return ct;
}
