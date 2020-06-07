
AR	= ar
AS	= as
LD	= ld
LDFLAGS	= -s -x -nostdlib
CC	= gcc

GCC_DEF = -D_KSCM_KERNEL -DDEBUG_MSG
# GCC_DEF = -DDEBUG_MSG
GCC_OPT =

CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce \
	$(GCC_OPT) $(GCC_DEF) \
	-finline-functions -nostdinc -I../../include -I.
CPP	= gcc -E -nostdinc -I../../include
# CFLAGS	= -Wall -finline-functions \
# 	$(GCC_OPT) $(GCC_DEF) -g -DTEST_SCHEME
# CPP	= $(CC) $(GCC_DEF) -E -DTEST_SCHEME

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS = bool.o sstring.o list.o vector.o read.o port.o numb.o gc.o \
	symbol.o display.o env.o proc.o eval.o  salloc.o core.o arch.o

all: scheme.o

test:test.o scheme.o
	$(CC) test.o scheme.o -o test

scheme.o: $(OBJS)
	$(LD) -r -o scheme.o $(OBJS)

tags:
	etags *.[ch]

clean:
	rm -f core *.o *.a tmp_make TAGS
	for i in *.c;do rm -f `basename $$i .c`.s;done

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile

### Dependencies:
arch.s arch.o: arch.c arch.h ../../include/asm/system.h ../../include/asm/io.h \
  ../../include/sys/types.h ./scheme.h ../../include/stdlib.h \
  ../../include/errno.h numb.h scheme.h ../../include/kscm/mm.h
bool.s bool.o: bool.c bool.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h env.h
core.s core.o: core.c scheme.h ../../include/stdlib.h ../../include/sys/types.h \
  ../../include/errno.h env.h read.h port.h bool.h numb.h sstring.h \
  list.h eval.h display.h
display.s display.o: display.c display.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h list.h vector.h \
  sstring.h ../../include/stdio.h ../../include/stdarg.h \
  ../../include/string.h ../../include/ctype.h
env.s env.o: env.c env.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h list.h \
  symbol.h proc.h ../../include/stdio.h ../../include/stdarg.h \
  ../../include/string.h ../../include/ctype.h
eval.s eval.o: eval.c eval.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h list.h env.h \
  proc.h ../../include/stdio.h ../../include/stdarg.h
gc.s gc.o: gc.c gc.h scheme.h ../../include/stdlib.h ../../include/sys/types.h \
  ../../include/errno.h ../../include/kscm/config.h \
  ../../include/kscm/mm.h
hash.s hash.o: hash.c hash.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h \
  ../../include/stdio.h ../../include/stdarg.h
list.s list.o: list.c list.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h env.h salloc.h \
  display.h
numb.s numb.o: numb.c numb.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h env.h \
  ../../include/stdio.h ../../include/stdarg.h
port.s port.o: port.c port.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h env.h symbol.h \
  ../../include/asm/system.h ../../include/asm/io.h ../../include/stdio.h \
  ../../include/stdarg.h
proc.s proc.o: proc.c proc.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h eval.h salloc.h list.h \
  env.h ../../include/stdio.h ../../include/stdarg.h
read.s read.o: read.c read.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h env.h salloc.h list.h \
  port.h syylex.h symbol.h numb.h sstring.h ../../include/stdio.h \
  ../../include/stdarg.h ../../include/string.h ../../include/ctype.h
salloc.s salloc.o: salloc.c salloc.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h
sstring.s sstring.o: sstring.c sstring.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h env.h salloc.h \
  ../../include/string.h ../../include/ctype.h
symbol.s symbol.o: symbol.c symbol.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h sstring.h \
  hash.h ../../include/string.h ../../include/ctype.h
test.s test.o: test.c scheme.h ../../include/stdlib.h ../../include/sys/types.h \
  ../../include/errno.h salloc.h port.h sstring.h bool.h numb.h read.h \
  syylex.h display.h eval.h hash.h env.h ../../include/stdio.h \
  ../../include/stdarg.h ../../include/ctype.h
vector.s vector.o: vector.c vector.h scheme.h ../../include/stdlib.h \
  ../../include/sys/types.h ../../include/errno.h salloc.h display.h
