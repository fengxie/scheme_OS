
CC	= gcc
# FIXME: For runtime library we may don't need to add option -fomit-frame-pointer for gcc
GCC_OPT = -fomit-frame-pointer	
INCLUDES = -I$(TOP_PATH)/include
LIBRARYS = -L$(TOP_PATH)/lib

CFLAGS	= -W -Wall -g $(GCC_OPT) $(INCLUDES) $(LIBRARYS)
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
