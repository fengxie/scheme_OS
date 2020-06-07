# Top level make file

TOP_PATH := $(shell pwd)
export TOP_PATH

SUBDIRS = lib src tests

all:
	make -C lib
	make -C src
	make -C tests

.PHONY: tests
tests:
	make -C tests

clean:
	(for i in $(SUBDIRS); do make clean -C $$i; done)

dep:
	(for i in $(SUBDIRS); do make dep -C $$i; done)
