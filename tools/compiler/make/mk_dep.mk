
# FIXME: Need a better version
dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
ifdef SUBDIRS
	(for i in $(SUBDIRS); do make dep -C $$i; done)
endif