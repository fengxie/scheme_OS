
AS86    = as86 -0 -a
LD86    = ld86 -0

AR	= ar
AS	= as
LD	= ld
LDFLAGS	= -s -x -Ttext 0x0
CC	= gcc
CFLAGS	= -Wall -O -fno-builtin -fstrength-reduce $(GCC_OPT) \
	-finline-functions -nostdinc -Iinclude
CPP	= cpp -nostdinc -Iinclude

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

IMAGE	= boot/kscmOs.img
OBJS 	= boot/head.o

KSCM 	= kscm/kscm.o
LIBS	= lib/lib.a
MM	= mm/mm.o

all:$(IMAGE) debug/system.elf

$(IMAGE): boot/bootsect boot/setup system 
	cat boot/bootsect boot/setup system > $(IMAGE)
	sync

boot/bootsect: boot/bootsect.s 
	$(AS86) -b boot/bootsect $<

boot/setup: boot/setup.s
	$(AS86) -b boot/setup $<

boot/bootsect.s: boot/bootsect.S include/kscm/config.h
	$(CPP) -traditional boot/bootsect.S -o boot/bootsect.s

boot/setup.s: boot/setup.S include/kscm/config.h
	$(CPP) -traditional boot/setup.S -o boot/setup.s

# boot/bootsect.o:boot/bootsect.S

# boot/setup.o:boot/setup.S

boot/head.o:boot/head.s
	$(AS) -o $*.o $<

boot/head.s: boot/head.S include/kscm/config.h
	$(CPP) -traditional boot/head.S -o boot/head.s

system:boot/head.o $(KSCM) $(LIBS) $(MM)
	$(LD) $(LDFLAGS) --oformat binary -M \
	boot/head.o \
	kscm/kscm.o \
	$(LIBS) $(MM) \
	-o system > System.map

debug/system.elf: boot/head.o $(KSCM) $(LIBS) $(MM)
	$(LD) -Ttext 0x0 \
	boot/head.o \
	kscm/kscm.o \
	$(LIBS) $(MM) \
	-o debug/system.elf
	objdump -d debug/system.elf > debug/dasm

.PHONY: $(KSCM)
$(KSCM):
	(cd kscm; make)

.PHONY: $(LIBS)
$(LIBS):
	(cd lib; make)

.PHONY: $(MM)
$(MM):
	(cd mm; make)

clean:
	rm -f core *.o *.a tmp_make keyboard.s boot/bootsect boot/setup \
		boot/setup.s boot/bootsect.s boot/head.o
	for i in *.c;do rm -f `basename $$i .c`.s;done
	(cd kscm; make clean)
	(cd lib; make clean)

dep:
	(make dep -C kscm/)
	(make dep -C lib/)
	(make dep -C mm/)

### Dependencies:
