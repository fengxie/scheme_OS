
#include <kscm/config.h>

entry 	start
start:	

show_load_msg:
	mov	ah, #0x03
	xor	bh, bh
	int	0x10
	mov	cx, #18
	mov	bx, #0x0007
	mov	bp, #load_msg
	mov	ax, #0x1301
	int	0x10

	mov	ax, #INITSEG
	mov	ds, ax

	mov	ah, #0x03
	xor 	dh, dh
	int	0x10
	mov	[0], dx
	
	mov	ah, #0x88
	int	0x15
	mov	[2], ax		; 存贮扩展内存数值

	;; 获取视频卡数据
	mov	ah, #0x0f
	int	0x10
	mov	[4], bx		; bh display page
	mov	[6], ax		; ah 每行字数 al 显示模式号

	;; 检查显示方式，并取参数
	mov	ah, #0x12
	mov	bl, #0x10
	int	0x10
	mov	[8], ax
	mov	[10], bx	; 0x9000a = 显示内存 0x9000b 显示状态
	mov	[12], cx	; 显卡特性参数

	;; 获取第一个硬盘参数 hd0
	;; get hd1 data

	;; begin to setup protect mode

	cli
	;; ;; mov	ax, #0x0000
	xor	ax, ax
	cld

do_move:	
	mov	es, ax
	add	ax, #0x1000
	cmp	ax, #0x9000
	jz	end_move

	mov	ds, ax		; set ds to #0x1000
	sub	di, di
	sub	si, si
	mov	cx, #0x8000
	rep
	movsw
	jmp	do_move
end_move:	

	cli
	mov	ax, #SETUPSEG
	mov	ds, ax
	lidt	idt_48
	lgdt	gdt_48

	call	empty_8042
	mov	al,#0xD1		! command write
	out	#0x64,al
	call	empty_8042
	mov	al,#0xDF		! A20 on
	out	#0x60,al
	call	empty_8042

setup_8259a:
	mov	al, #0x11		! write ICW1 of master
	out	#0x20, al
	.word	0x00eb, 0x00eb		! delay
	out	#0xa0, al		! write ICW1 of slave
	.word	0x00eb, 0x00eb
	
	mov	al, #0x20		! write ICW2, set hardware int from 0x20
	out	#0x21, al
	.word	0x00eb, 0x00eb
	mov	al, #0x28		! for slave hardware int from 0x28
	.word	0x00eb, 0x00eb

	mov	al, #0x4
	out	#0x21, al		! set the 8259-1 as master
	.word	0x00eb, 0x00eb
	mov	al, #0x2		! indicates that the slave is linked to master at IRQ2
	out	#0xa1, al		! set the 8259-1 as master
	.word	0x00eb, 0x00eb
	
	mov	al, #0x1		! set mode: 86/88, EOI, non-buffer
	out	#0x21, al
	.word	0x00eb, 0x00eb
	out	#0xa1, al
	.word	0x00eb, 0x00eb

	! mov	al, #0xff
	!out	#0x21, al
	!.word	0x00eb, 0x00eb
	!out	#0xa1, al
	
	! then enter 32bit protect mode and jump to execute system module
	mov	ax, #0x0001
	lmsw	ax

	! before jump to execute system print some message
	jmpi	0, 8

! Copy from Linux 0.11
! This routine checks that the keyboard command queue is empty
! No timeout is used - if this hangs there is something wrong with
! the machine, and we probably couldn't proceed anyway.
empty_8042:
	.word	0x00eb,0x00eb
	in	al,#0x64	! 8042 status port
	test	al,#2		! is input buffer full?
	jnz	empty_8042	! yes - loop
	ret

load_msg:
	.byte	13, 10
	.ascii	"Loading setup..."

	org	432
gdt:				; global descriptor table
	.word	0, 0, 0, 0
	;; first available item of global descriptor table. offset 0x08
	.word	0x07ff
	.word	0x0000
	.word	0x9A00		! code read/exec
	.word	0x00c0		; highest word of descriptor

	.word	0x07ff		! 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		! base address=0
	.word	0x9200		! data read/write
	.word	0x00C0		! granularity=4096, 386

	;; stack segment in kernel space
	.word	0x07ff		; size 8mb
	.word	0x0000		! base address= 0x100000
	.word	0x9210		! data read/write & base address = 0x100000
	.word	0x00C0		! granularity=4096, 386

	org	500
	
idt_48:
	.word	0
	.word	0, 0

gdt_48:
	.word	0x800		; limit = 2048k
	.word	512 + gdt, 0x9
