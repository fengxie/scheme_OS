
#include <kscm/config.h>

#include <ansidecl.h>
#include <stdlib.h>

#define __HEXTOASCII(d) (((d) >= 0 && (d) <= 9)? '0' + (d): 'A' + (d) - 10)

#undef	atoi

/* Convert a string to an int.  */
int atoi(const char *nptr)
{
  return((int) strtol(nptr, (char **) NULL, 10));
}

#undef	atol

/* Convert a string to a long int.  */
long int atol(const char *nptr)
{
  return(strtol(nptr, (char **) NULL, 10));
}

char *_itoa(unsigned int numb, char *buf, int radix)
{
	return buf;
}

/* locals */
static inline void __itoaU_oct(unsigned int numb, char *buf)
{
	
}

static inline void __itoaU_dec(unsigned int numb, char *buf)
{
	int t = 1000000000;
	char *p = buf;

	*buf = '0'; *(buf + 1) = '\0';
	if (numb == 0)
		return;
	
	while (t > 0 && numb / t == 0)
		t /= 10;
	
	*p++ = '0' + numb / t; numb %= t; t /= 10;
	while (t != 0) {
		*p++ = '0' + numb / t;
		numb %= t;
		t /= 10;
	}

	*p = '\0';
}

static inline void __itoaU_hex(unsigned int numb, char *buf)
{
	int t = 0xf0000000, ct = 8, s;
	char *p = buf;

	*buf = '0'; *(buf + 1) = '\0';
	if (numb == 0)
		return;
	
	while ((t & numb) == 0 && ct > 0) {
		numb <<= 4;
		ct--;
	}

	while (ct != 0) {
		*p++ = __HEXTOASCII((t & numb) >> 28);
		numb <<= 4;
		ct--;
	}

	*p = '\0';
}

/* unsigned integer to string(now support hex only) */
char *_itoaU(unsigned int numb, char *buf, int radix)
{
	switch (radix) {
	case 8:
		__itoaU_oct(numb, buf);
		break;
	case 16:
		__itoaU_hex(numb, buf);
		break;
	default:		/* default to decimal */
		__itoaU_dec(numb, buf);
		break;
	}

	return buf;
}

