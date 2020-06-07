
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

static char _g_print_buf[1024];

int printf(const char *fmt, ...)
{
	int ct;
	va_list ap;
	
	va_start(ap, fmt);
	ct = vsprintf(_g_print_buf, fmt, ap);
	va_end(ap);

	console_print(_g_print_buf);

	return ct;
}

int sprintf(char *str, const char *format, ...)
{
	int ct;
	va_list ap;

	va_start(ap, format);
	ct = vsprintf(str, format, ap);
	va_end(ap);
	
	return ct;
}

int vsprintf(char *str, const char *format, va_list ap)
{
	int ct;
	char *p, *pstr;

	for (ct = 0, p = format; *p; p++) {
		if (*p != '%') {
			*str++ = *p;
			ct++;
			continue;
		}
		switch (*++p) {
		case '%':
			*str++ = '%';
			ct++;
			break;
		case 'd': case 'i':
			_itoaU(va_arg(ap, unsigned int), str, 10);
			while (*str) { str++; ct++; }
			break;
		case 'c':
			*str++ = va_arg(ap, char);
			ct++;
			break;
		case 's':
			pstr = va_arg(ap, char *);
			while ((*str++ = *pstr++) != 0)
				ct++;
			str--;
			break;
		case 'x':
			_itoaU(va_arg(ap, unsigned int),
			       str, 16);
			while (*str) { str++; ct++; }
			break;
		default:
			break;
		}
	}
	*str = '\0';
	
	return ct;
}
