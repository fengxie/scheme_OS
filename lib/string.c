#include "string.h"

void *memset(void *s, int c, size_t n)
{
	void *__res = s;

	c &= 0xff;
	c |= (c << 8);
	c |= (c << 16);
	__asm__ volatile (
		"pushl %%edi\n\t"
		"pushl %%ecx\n\t"
		"cld\n\t"
		"rep\n\t"
		"stosl\n\t"
		"movl %%edx, %%ecx\n\t"
		"rep\n\t"
		"stosb\n\t"
		"popl %%ecx\n\t"
		"popl %%edi\n\t"
		:
		: "D" ((long)__res), "a"((long)c), "c" ((long)(n & ~0x3)), "d"((long)(n & 0x3))
		: "memory");
	
	return __res;
}
