
ifndef TOP_PATH
TOP_PATH = ./../..
endif

include $(TOP_PATH)/make/comm_def.mk
include $(TOP_PATH)/make/scm_cc.mk


# CC	= gcc
# GCC_OPT = -fomit-frame-pointer
# INCLUDES = -I../../include
# CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce \
# 	$(GCC_OPT) $(INCLUDES) \
# 	-finline-functions -nostdinc
# CFLAGS	= -W -Wall -g $(GCC_OPT) $(INCLUDES)
# CPP	= gcc -E $(INCLUDES)

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

SUBDIRS = 
OBJS = builtin.o display.o numb.o

all: builtins.o

builtins.o: $(OBJS)
	$(LD) -r -o builtins.o $(OBJS)

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

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
	(for i in $(SUBDIRS); do make -C $$i; done)

### Dependencies:
builtin.s builtin.o: builtin.c \
 /home/feng/dev/scheme_OS/tools/compiler/include/config.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtin.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/svm.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/scheme.h \
 /usr/include/sys/types.h /usr/include/features.h \
 /usr/include/bits/predefs.h /usr/include/sys/cdefs.h \
 /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h \
 /usr/include/gnu/stubs-32.h /usr/include/bits/types.h \
 /usr/include/bits/typesizes.h /usr/include/time.h \
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stddef.h /usr/include/endian.h \
 /usr/include/bits/endian.h /usr/include/bits/byteswap.h \
 /usr/include/sys/select.h /usr/include/bits/select.h \
 /usr/include/bits/sigset.h /usr/include/bits/time.h \
 /usr/include/sys/sysmacros.h /usr/include/bits/pthreadtypes.h \
 /usr/include/assert.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/cc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/gc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/display.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/numb.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/debug.h \
 /usr/include/stdio.h /usr/include/libio.h /usr/include/_G_config.h \
 /usr/include/wchar.h /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stdarg.h \
 /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
 /usr/include/stdlib.h /usr/include/alloca.h
display.s display.o: display.c \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/display.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtin.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/svm.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/scheme.h \
 /usr/include/sys/types.h /usr/include/features.h \
 /usr/include/bits/predefs.h /usr/include/sys/cdefs.h \
 /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h \
 /usr/include/gnu/stubs-32.h /usr/include/bits/types.h \
 /usr/include/bits/typesizes.h /usr/include/time.h \
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stddef.h /usr/include/endian.h \
 /usr/include/bits/endian.h /usr/include/bits/byteswap.h \
 /usr/include/sys/select.h /usr/include/bits/select.h \
 /usr/include/bits/sigset.h /usr/include/bits/time.h \
 /usr/include/sys/sysmacros.h /usr/include/bits/pthreadtypes.h \
 /usr/include/assert.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/cc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/gc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/numb.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/config.h \
 /usr/include/stdio.h /usr/include/libio.h /usr/include/_G_config.h \
 /usr/include/wchar.h /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stdarg.h \
 /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
 /usr/include/stdlib.h /usr/include/alloca.h
numb.s numb.o: numb.c \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/numb.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtin.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/svm.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/scheme.h \
 /usr/include/sys/types.h /usr/include/features.h \
 /usr/include/bits/predefs.h /usr/include/sys/cdefs.h \
 /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h \
 /usr/include/gnu/stubs-32.h /usr/include/bits/types.h \
 /usr/include/bits/typesizes.h /usr/include/time.h \
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stddef.h /usr/include/endian.h \
 /usr/include/bits/endian.h /usr/include/bits/byteswap.h \
 /usr/include/sys/select.h /usr/include/bits/select.h \
 /usr/include/bits/sigset.h /usr/include/bits/time.h \
 /usr/include/sys/sysmacros.h /usr/include/bits/pthreadtypes.h \
 /usr/include/assert.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/cc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/gc.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/builtins/display.h \
 /home/feng/dev/scheme_OS/tools/compiler/include/config.h \
 /usr/include/stdio.h /usr/include/libio.h /usr/include/_G_config.h \
 /usr/include/wchar.h /usr/lib/gcc/i486-linux-gnu/4.4.5/include/stdarg.h \
 /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
 /usr/include/stdlib.h /usr/include/alloca.h
