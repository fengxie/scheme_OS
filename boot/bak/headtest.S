
#include <kscm/config.h>
.text
.globl	_start, _idt, _gdt, print_reg32
_start:	
	cld

	/* reload all segment selector */
	mov	$0x10, %ax
	mov	%ax, %ds
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs
	
	movl	#K_STACK_SIZE, %esp	/* setup stack */
	/*
	 * I'm so faint about this problem which boring
	 * me several days. Now I know it is all because
	 * `ld' use a none-zero address for start address
	 * lgdt use the absolute address.
	 */
	call	setup_idt
	call	setup_gdt
/*	mov	$0x8, %ax 
	mov	%ax, %cs*/

	mov	$0x10, %eax
	mov	%ax, %ds
	mov	%ax, %ss	
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs

	/* check A20 */
        xorl %eax,%eax
1:      incl %eax               # check that A20 really IS enabled
        movl %eax,0x000000      # loop forever if it isn't
        cmpl %eax,0x100000
        je 1b

	/*
	 * before enter C program, I must set data
	 * segment to stack segment to let the code
	 * work correctly.
	 */

	movl	$0x800000, %esp		/* initial a  stack for c */
	movl	$0x800000, %ebp
/*
died_loop:
	jmp	died_loop */
	call	main	/* begin main process */
/*
print_reg32:
	pushl	%ecx
	pushl	%ebx
	push	%dx
	push	%es
	pushl	%eax
	mov	$0x10, %eax
	mov	%eax, %es
	popl	%eax
	movl	$8, %ecx
	movl	$0xb801e, %ebx
	movw	$0x0f0f, %dx
l32_1:
	and	%al, %dl
	cmp	$0xa, %dl
	jl	l32_a
	sub	$0xa, %dl
	add	$0x41, %dl
	jmp	l32_pchar
l32_a:
	add	$'0', %dl
l32_pchar:	
	movw	%dx, %es:(%ebx)
	shr	$4, %eax
	sub	$0x2, %ebx
	movw	$0x0f0f, %dx
	loop	l32_1

	pop	%es
	pop	%dx
	popl	%ebx
	popl	%ecx
	ret
*/
setup_idt:
        lea ignore_int,%edx
        movl $0x00080000,%eax
        movw %dx,%ax            /* selector = 0x0008 = cs */
        movw $0x8E00,%dx        /* interrupt gate - dpl=0, present */

        lea _idt,%edi
        mov $256,%ecx
	/* initialize all interupt to associate with ignore_int */
rp_sidt:
        movl %eax,(%edi)
        movl %edx,4(%edi)
        addl $8,%edi
        dec %ecx
        jne rp_sidt
        lidt idt_descr
        ret

setup_gdt:
	lgdt	gdt_descr
	ret
	
/* This is the default interrupt "handler" :-) */
int_msg:
        .asciz "Unknown interrupt\n\r\0"
.align 2
ignore_int:
        cld
	
        pushl %eax
        pushl %ecx
        pushl %edx
        push %ds
        push %es
        push %fs
        movl $0x10,%eax
        mov %ax,%ds
        mov %ax,%es
        mov %ax,%fs
        pushl $int_msg
        call printk
        popl %eax
        pop %fs
        pop %es
        pop %ds
        popl %edx
        popl %ecx
        popl %eax
        iret
	
	.align 2
	.word 0
idt_descr:
	.word 256*8-1		# idt contains 256 entries
	.long _idt
	
	.align 2
	.word 0
gdt_descr:
	.word 256*8-1		# so does gdt (not that that's any
	.long _gdt		# magic number, but it works for me :^)

	.align 2
_idt:
	.fill 256,8,0		# idt is uninitialized

_gdt:
	.quad 0x0000000000000000	/* NULL descriptor */
	.quad 0x00c09a0000000fff	/* 16Mb */
	.quad 0x00c0920000000fff	/* 16Mb */
	.quad 0x00c0921000000fff	/* stack 8Mb */
	.quad 0x0000000000000000	/* TEMPORARY - don't use */
	.fill 251,8,0			/* space for LDT's and TSS's etc */
