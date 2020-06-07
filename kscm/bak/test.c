#include <stdarg.h>

int test(char *a, ...)
{
	va_list ap = &a;
	int fst;
	
	va_start(ap, a);
	fst = va_arg(ap, int);
	
	/* 
         * __asm__(
	 * 	/\* "movl 12(%%ebp), %%eax\n\t" *\/
	 * 	"call print_reg32\n\t"
	 * 	:
	 * 	: "a"(fst));
         */
	
	va_end(ap);
	
	return 0;
}
