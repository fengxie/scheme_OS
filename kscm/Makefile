
AR	= ar
AS	= as
LD	= ld
LDFLAGS	= -s -x -nostdlib
CC	= gcc
CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce \
	$(GCC_OPT) \
	-finline-functions -nostdinc -I../include 
CPP	= gcc -E -nostdinc -I../include

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS = console.o start.o proc.o keyboard.o scheme/scheme.o


all: kscm.o

kscm.o: $(OBJS)
	$(LD) -r -o kscm.o $(OBJS)

keyboard.s : keyboard.S ../include/kscm/config.h
	$(CPP) -traditional keyboard.S -o keyboard.s

.PHONY: scheme/scheme.o
scheme/scheme.o:
	(cd scheme; make)

clean:
	rm -f core *.o *.a tmp_make keyboard.s
	for i in *.c;do rm -f `basename $$i .c`.s;done
	(cd scheme; make clean)

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
	(cd scheme; make dep)

### Dependencies:
console.s console.o: console.c ../include/kscm/config.h ../include/stdlib.h \
 ../include/sys/types.h ../include/errno.h ../include/string.h \
 ../include/ctype.h
proc.s proc.o: proc.c ../include/kscm/config.h ../include/kscm/proc.h \
 ../include/kscm/mm.h ../include/sys/types.h
start.s start.o: start.c ../include/kscm/config.h ../include/asm/page.h \
 ../include/sys/types.h ../include/asm/system.h ../include/asm/io.h \
 ../include/kscm/mm.h ../include/kscm/proc.h ../include/debug.h \
 ../include/stdio.h ../include/stdarg.h ../include/stdlib.h \
 ../include/errno.h ../include/ctype.h ../include/string.h \
 scheme/scheme.h scheme/read.h scheme/scheme.h scheme/env.h \
 scheme/display.h scheme/port.h scheme/eval.h
