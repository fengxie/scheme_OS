#ifndef IO_H
#define IO_H

static void inline outb(unsigned short port, char value)
{
	__asm__ volatile ("outb %0,%1"::"a" (value),"d" (port));
}

static unsigned char inline inb(unsigned short port)
{
	unsigned char _v;

	__asm__ volatile ("inb %1, %0":"=a" (_v):"d" (port));

	return _v;
}

#endif
