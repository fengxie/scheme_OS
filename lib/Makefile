
AR	= ar
AS	= as
LD	= ld
LDFLAGS	= -s -x -nostdlib
CC	= gcc

CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce \
	$(GCC_OPT) \
	-finline-functions -nostdinc -I../include 
CPP	= cpp -nostdinc -I../include

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

LIBS = lib.a
OBJS = number.o errno.o malloc.o strtol.o string.o print.o

all: lib.a

lib.a: $(OBJS)
	$(AR) cr $*.a $(OBJS)

clean:
	rm -f core *.o *.a tmp_make keyboard.s
	for i in *.c;do rm -f `basename $$i .c`.s;done
# (cd chr_drv; make clean)
# (cd blk_drv; make clean)
# (cd math; make clean)

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
# (cd chr_drv; make dep)
# (cd blk_drv; make dep)

### Dependencies:
errno.s errno.o: errno.c ../include/errno.h
malloc.s malloc.o: malloc.c ../include/stdlib.h ../include/sys/types.h \
 ../include/errno.h ../include/stdio.h ../include/stdarg.h \
 ../include/kscm/mm.h ../include/kscm/config.h ../include/asm/page.h
number.s number.o: number.c ../include/kscm/config.h ../include/ansidecl.h \
 ../include/stdlib.h ../include/sys/types.h ../include/errno.h
print.s print.o: print.c ../include/stdio.h ../include/sys/types.h \
 ../include/stdarg.h ../include/stdlib.h ../include/errno.h \
 ../include/string.h ../include/ctype.h
string.s string.o: string.c ../include/string.h ../include/sys/types.h \
 ../include/ctype.h
strtol.s strtol.o: strtol.c ../include/ctype.h ../include/limits.h \
 ../include/stdlib.h ../include/sys/types.h ../include/errno.h
tst_string.s tst_string.o: tst_string.c ../include/string.h ../include/sys/types.h \
 ../include/ctype.h
