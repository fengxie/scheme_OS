
#ifndef STDARG_H
#define STDARG_H

typedef char *va_list;

/* from linux kernel source v0.11 */

#define __va_rounded_size(TYPE)  \
  (((sizeof(TYPE) + sizeof(int) - 1) / sizeof(int)) * sizeof(int))

#define va_start(ap, lastarg)				\
	(ap = (char *)(&lastarg) + __va_rounded_size(lastarg))

#define va_end(ap)

#define va_arg(ap, type)					\
	(ap += __va_rounded_size(type),					\
	 *((type *)(ap - __va_rounded_size(type))))

#endif
