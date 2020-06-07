
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
	mov	cx, #21
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

	mov	ax, #0x0800
	int	0x13
	and	cl, #0x3f
	mov	max_sec_per_track, cl
	
load_system:
	mov	ax, #SYSSEG
	mov	es, ax

	;; setup the start-up point for read_block
	mov	dx, #0x0000	; head 0, disk 0x0(A:)
	mov	cx, #0x0003	; sector cl(5-0), cylinder cl(7-6) : ch
	mov	bx, #0x0000	; I/O buffer at es:bx
	mov	ax, #0x80	; number of requested sectors

	call	read_block
	
jump_to_setup:	
	mov	ax, #SETUPSEG
	mov	es, ax
	jmpi	0, #SETUPSEG
	;; mov	ax, #SYSSEG
	;; mov	es, ax
	;; jmpi	0, #SYSSEG

	;; data structure for proc `read_block'
nr_sector:
	.word	0
	
	;; read one sector from disk A:
	;; read `ax' sectors frome A:
read_block:
	;; save para into memory
	push	es
	mov	nr_sector, ax

do_read_sector:
	;; read one sector
	mov	ax,#0x0201
	int	0x13
	jnc	next_sector
	;; error reset and read again
	push	dx
	xor	dx, dx
	xor	ax, ax
	int	0x13
	pop	dx
	jmp	do_read_sector

next_sector:	
	inc	cl
	cmp	cl, #0x13
	jne	test_if_finish
	mov	cl, #0x1	; end of track, back to 1
	cmp	dh, #0x0
	je	change_side	; do not move to the next cylinder
	;; move to the next track
	inc	ch

	;; show pregress
	push 	ax
	push	bx
	push	cx
	push	bp
	push	dx
	push	es
	
	mov	ah, #0x03
	xor	bh, bh
	int	0x10
	mov	cx, #4
	mov	bx, #0x0007
	mov	bp, #loading_msg
	mov	ax, #INITSEG
	mov	es, ax
	mov	ax, #0x1301
	int	0x10

	pop	es
	pop	dx
	pop	bp
	pop	cx
	pop	bx
	pop	ax

change_side:
	xor	dh, #0x1

test_if_finish:
	mov	ax,nr_sector
	dec	ax
	jz	read_block_ok	; work done!
	mov	nr_sector, ax
	mov	ax, es
	add	ax, #0x20	; point to the next 512 memory block
	mov	es, ax
	jmp	do_read_sector
read_block_ok:	

	pop	es
	ret

disk_paras:
max_sec_per_track:
	.byte	0

load_msg:
	.byte	13, 10
	.ascii	"Loading system..."
	.byte	13, 10

loading_msg:	
	.ascii "()()"
	
	org	511

	.byte	0
