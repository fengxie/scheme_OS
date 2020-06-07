
ifndef TOP_PATH
TOP_PATH := ./../..
endif

include $(TOP_PATH)/make/scm_cc.mk

SCM2C = $(TOP_PATH)/src/scm2c

.SUFFIXES: .scm

.scm.c:
	$(SCM2C) $< -C -o $*.c --c-flags "$(CFLAGS)"

TEST_EXE = $(shell for i in *.scm; do \
	echo -n `basename $$i .scm`; \
	echo -n " "; done)

all: tests

$(SCM2C):
	make -C $(TOP_PATH)/src

.PHONY: tests
tests: $(SCM2C) $(TEST_EXE)
	rm -rf *.c~

clean:
	rm -rf $(TEST_EXE) *.c *.c~

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.scm;do \
	printf "%s: %s $(SCM2C)\n" `basename $$i .scm` $$i; printf "\t$(SCM2C) %s -C\n" $$i; \
	printf "\t$(SCM2C) %s -o %s --c-flags \"$(CFLAGS)\"\n\n" $$i `basename $$i .scm`; done) >> tmp_make
	cp tmp_make Makefile

### Dependencies:
iter: iter.scm /home/feng/dev/scheme_OS/tools/compiler/src/scm2c
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c iter.scm -C
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c iter.scm -o iter --c-flags "-W -Wall -g -fomit-frame-pointer	 -I/home/feng/dev/scheme_OS/tools/compiler/include -L/home/feng/dev/scheme_OS/tools/compiler/lib"

psvmst: psvmst.scm /home/feng/dev/scheme_OS/tools/compiler/src/scm2c
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c psvmst.scm -C
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c psvmst.scm -o psvmst --c-flags "-W -Wall -g -fomit-frame-pointer	 -I/home/feng/dev/scheme_OS/tools/compiler/include -L/home/feng/dev/scheme_OS/tools/compiler/lib"

test: test.scm /home/feng/dev/scheme_OS/tools/compiler/src/scm2c
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c test.scm -C
	/home/feng/dev/scheme_OS/tools/compiler/src/scm2c test.scm -o test --c-flags "-W -Wall -g -fomit-frame-pointer	 -I/home/feng/dev/scheme_OS/tools/compiler/include -L/home/feng/dev/scheme_OS/tools/compiler/lib"

