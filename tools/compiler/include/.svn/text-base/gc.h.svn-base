#ifndef GC_H
#define GC_H

#include <scheme.h>

typedef struct Space {
	void *start;
	unsigned long size;
} Space_t;

extern int gc_init(void);
extern void gc_alloc_obj(Scheme_Type_t type, int size);

#include <cc.h>

#define new_obj(type, size) do {					\
		__asm__ volatile (					\
			"pushl %1\n\t"					\
			"pushl %0\n\t"					\
			"call " C_SYM_TO_ASM(gc_alloc_obj) "\n\t"	\
			"addl $8, %%esp\n\t"				\
			:						\
			: "a"(type), "d"(size)				\
			: "memory");					\
	} while (0)

#endif
