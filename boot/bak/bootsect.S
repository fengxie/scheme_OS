
#include <kscm/config.h>

entry 	start
start:
	mov	ax, #BOOTSEG
	mov	ds, ax
	mov	ax, #INITSEG
	mov	es, ax
	mov	cx, #256
	sub	si, si
	sub	di, di
	rep
	movw
	jmpi	go, #INITSEG

go:	
	mov	ax, cs
	mov	ds, ax
	mov	es, ax

show_load_msg:
	mov	ah, #0x03
	xor	bh, bh
	int	0x10
	mov	cx, #19
	mov	bx, #0x0007
	mov	bp, #load_msg
	mov	ax, #0x1301
	int	0x10

load_setup:
	mov	ax, #SETUPSEG
	mov	es, ax
	mov	dx, #0x0000
	mov	cx, #0002
	mov	bx, #0x0000
	mov	ax, #0x0201
	int	0x13
	jnc	load_setup_ok
	mov	dx, #0x0000
	mov	ax, #0x0000
	int	0x13
	jmp	load_setup
load_setup_ok:

load_system:
	mov	ax, #SYSSEG
	mov	es, ax
	mov	dx, #0x0000
	mov	cx, #0x0003
	mov	bx, #0x0000
	mov	ax, #0x0240

	int	0x13
	jnc	load_system_ok
	mov	dx, #0x0000
	mov	ax, #0x0000
	int	0x13
	jmp	load_system
load_system_ok:
	
jump_to_setup:	
	mov	ax, #SETUPSEG
	mov	es, ax
	jmpi	0, #SETUPSEG
	;; mov	ax, #SYSSEG
	;; mov	es, ax
	;; jmpi	0, #SYSSEG

load_msg:
	.byte	13, 10
	.ascii	"Loading system..."

	org	511

	.byte	0
