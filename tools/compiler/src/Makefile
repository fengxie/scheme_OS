
ifndef TOP_PATH
TOP_PATH = ./..
endif

include $(TOP_PATH)/make/comm_def.mk

include $(TOP_PATH)/make/project.mk

LEX = alex
YACC = happy
GHC = ghc -hide-package monads-fd

OBJS = Exptype.o Scmlex.o Parser.o Compiler.o

.SUFFIXES: .hi .hs .lo

.hs:
	$(GHC) --make $<

TEST_COMPILER = test

all: scm2c tst_lex tst_parser tst_compiler tst_scm2c

.PHONY: ../lib/libscheme.a

../lib/libscheme.a:
	make -C ../lib

test: test.o ../lib/libscheme.a
	$(CC) $(CFLAGS) -L../lib -o test test.o -lscheme

test.c: test.scm tst_scm2c
	./tst_scm2c < test.scm > test.c
	indent test.c -br -brs -fca -kr -nut

scm2c: Main.hs Convert.hs  Compiler.hs Scmlex.hs Parser.hs Builtin.hs Macro.hs
	$(GHC) --make Main.hs -o scm2c

tst_scm2c: tst_scm2c.hs Convert.hs Compiler.hs Exptype.hs Builtin.hs CSrc.hs
	$(GHC) --make tst_scm2c.hs -o tst_scm2c	

tst_compiler: tst_compiler.hs Exptype.hs Parser.hs  Compiler.hs SVM.hs Builtin.hs
	$(GHC) --make tst_compiler.hs -o tst_compiler

tst_parser: tst_parser.hs Scheme.hs SCM_Lex.hs SCM_Parser.hs ParserGen.hs
	$(GHC) --make tst_parser.hs -o tst_parser

tst_lex: tst_lex.hs SCM_Lex.hs
	$(GHC) --make tst_lex.hs -o tst_lex

Scmlex.hs: Scmlex.x
	$(LEX) Scmlex.x

SCM_Lex.hs: SCM_Lex.x
	$(LEX) SCM_Lex.x

Parser.hs: Parser.y
	$(YACC) Parser.y

new_parser:
	$(GHC) -fth --make Parser2.hs

clean:
	rm -rf *.hi *.o a.out tst_lex tst_parser tst_compiler tst_scm2c

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
	(for i in $(SUBDIRS); do make dep -C $$i; done)

### Dependencies:
_scm_test.s test.s test.o: test.c ../include/config.h ../include/svm.h ../include/scheme.h \
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
  ../include/builtin.h ../include/builtins/display.h \
  ../include/builtins/numb.h ../include/debug.h /usr/include/stdio.h \
  /usr/include/libio.h /usr/include/_G_config.h /usr/include/wchar.h \
  /usr/include/bits/wchar.h /usr/include/gconv.h \
  /usr/lib/gcc/i486-linux-gnu/3.4.6/include/stdarg.h \
  /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h \
  /usr/include/stdlib.h /usr/include/alloca.h
