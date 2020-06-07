
SUBDIRS = scm

.SUFFIXES: .scm

.scm.c:
	$(SCM2C) $< -o $*.c $(CFLAGS)

all: tests

.PHONY: tests
tests:
	(for i in $(SUBDIRS); do make tests -C $$i; done)

clean:
	(for i in $(SUBDIRS); do make clean -C $$i; done)

dep:
	(for i in $(SUBDIRS); do make dep -C $$i; done)

### Dependencies:
