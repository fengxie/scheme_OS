
AR	= ar
AS	= as
LD	= ld

CC	= gcc
GCC_OPT = -fomit-frame-pointer
INCLUDES = -I../include
# CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce \
# 	$(GCC_OPT) $(INCLUDES) \
# 	-finline-functions -nostdinc
CFLAGS	= -W -Wall -g $(GCC_OPT) $(INCLUDES)
CPP	= gcc -E $(INCLUDES)

.SUFFIXES: .lo

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) -g \
	-c -o $*.o $<
.s.lo:
	$(CC) $(CFLAGS) \
	-c -o $*.lo $<

SUBDIRS = builtins
LIBS = libscheme.a
OBJS = svm.o gc.o scheme.o builtins/builtins.o

TSTS = 

all: libscheme.a $(TSTS)

libscheme.a: $(OBJS)
	$(AR) cr $*.a $(OBJS)

.PHONY : builtins/builtins.o

builtins/builtins.o :
	make -C builtins

tst_svm: $(LIBS) tst_svm.o
	$(CC) $(CFLAGS) -L. -o tst_svm tst_svm.o -lscheme

test: $(LIBS) test.o
	$(CC) $(CFLAGS) -L. -o test test.o -lscheme

# tst_mod.lo: tst_mod.s
# 	$(CC) $(CFLAGS) \
# 	-c -o tst_mod.lo $<

# tst_mod.s: tst_mod.c ../include/svm.h ../include/scheme.h
# 	$(CC) $(CFLAGS) \
# 	-fomit-frame-pointer -S -o $*.s $<
# 	cp tst_mod.s tst_mod_bak.s
# 	sed -e '/ret$$/d' $*.s > temp.s
# 	mv temp.s $*.s
# 	sed -e '/%esp/d' -e '/%ebp/d' -e '/ret$$/d' $*.s > temp.s

clean:
	rm -f *.o *.a tmp_make
	for i in *.c;do rm -f `basename $$i .c`.s;done
	(for i in $(SUBDIRS); do make clean -C $$i; done)

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
	(for i in $(SUBDIRS); do make dep -C $$i; done)

### Dependencies:
gc.s gc.o: gc.c ../include/gc.h ../include/scheme.h /usr/include/sys/types.h \
  /usr/include/features.h /usr/include/sys/cdefs.h \
  /usr/include/gnu/stubs.h /usr/include/bits/types.h \
  /usr/include/bits/wordsize.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stddef.h \
  /usr/include/bits/typesizes.h /usr/include/time.h /usr/include/endian.h \
  /usr/include/bits/endian.h /usr/include/sys/select.h \
  /usr/include/bits/select.h /usr/include/bits/sigset.h \
  /usr/include/bits/time.h /usr/include/sys/sysmacros.h \
  /usr/include/bits/pthreadtypes.h /usr/include/bits/sched.h \
  ../include/cc.h ../include/svm.h /usr/include/assert.h \
  /usr/include/stdlib.h /usr/include/alloca.h
scheme.s scheme.o: scheme.c ../include/scheme.h /usr/include/sys/types.h \
  /usr/include/features.h /usr/include/sys/cdefs.h \
  /usr/include/gnu/stubs.h /usr/include/bits/types.h \
  /usr/include/bits/wordsize.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stddef.h \
  /usr/include/bits/typesizes.h /usr/include/time.h /usr/include/endian.h \
  /usr/include/bits/endian.h /usr/include/sys/select.h \
  /usr/include/bits/select.h /usr/include/bits/sigset.h \
  /usr/include/bits/time.h /usr/include/sys/sysmacros.h \
  /usr/include/bits/pthreadtypes.h /usr/include/bits/sched.h \
  ../include/svm.h /usr/include/assert.h ../include/cc.h ../include/gc.h \
  /usr/include/stdlib.h /usr/include/alloca.h
svm.s svm.o: svm.c ../include/svm.h ../include/scheme.h \
  /usr/include/sys/types.h /usr/include/features.h \
  /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h \
  /usr/include/bits/types.h /usr/include/bits/wordsize.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stddef.h \
  /usr/include/bits/typesizes.h /usr/include/time.h /usr/include/endian.h \
  /usr/include/bits/endian.h /usr/include/sys/select.h \
  /usr/include/bits/select.h /usr/include/bits/sigset.h \
  /usr/include/bits/time.h /usr/include/sys/sysmacros.h \
  /usr/include/bits/pthreadtypes.h /usr/include/bits/sched.h \
  /usr/include/assert.h ../include/cc.h ../include/gc.h \
  /usr/include/stdio.h /usr/include/libio.h /usr/include/_G_config.h \
  /usr/include/wchar.h /usr/include/bits/wchar.h /usr/include/gconv.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stdarg.h \
  /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
  /usr/include/stdlib.h /usr/include/alloca.h
test.s test.o: test.c ../include/svm.h ../include/scheme.h \
  /usr/include/sys/types.h /usr/include/features.h \
  /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h \
  /usr/include/bits/types.h /usr/include/bits/wordsize.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stddef.h \
  /usr/include/bits/typesizes.h /usr/include/time.h /usr/include/endian.h \
  /usr/include/bits/endian.h /usr/include/sys/select.h \
  /usr/include/bits/select.h /usr/include/bits/sigset.h \
  /usr/include/bits/time.h /usr/include/sys/sysmacros.h \
  /usr/include/bits/pthreadtypes.h /usr/include/bits/sched.h \
  /usr/include/assert.h ../include/cc.h ../include/gc.h \
  ../include/builtin.h ../include/builtins/display.h ../include/config.h \
  ../include/debug.h /usr/include/stdio.h /usr/include/libio.h \
  /usr/include/_G_config.h /usr/include/wchar.h /usr/include/bits/wchar.h \
  /usr/include/gconv.h /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stdarg.h \
  /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
  /usr/include/stdlib.h /usr/include/alloca.h
tst_svm.s tst_svm.o: tst_svm.c ../include/svm.h ../include/scheme.h \
  /usr/include/sys/types.h /usr/include/features.h \
  /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h \
  /usr/include/bits/types.h /usr/include/bits/wordsize.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stddef.h \
  /usr/include/bits/typesizes.h /usr/include/time.h /usr/include/endian.h \
  /usr/include/bits/endian.h /usr/include/sys/select.h \
  /usr/include/bits/select.h /usr/include/bits/sigset.h \
  /usr/include/bits/time.h /usr/include/sys/sysmacros.h \
  /usr/include/bits/pthreadtypes.h /usr/include/bits/sched.h \
  /usr/include/assert.h ../include/cc.h ../include/gc.h \
  /usr/include/stdio.h /usr/include/libio.h /usr/include/_G_config.h \
  /usr/include/wchar.h /usr/include/bits/wchar.h /usr/include/gconv.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stdarg.h \
  /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
  /usr/include/stdlib.h /usr/include/alloca.h
