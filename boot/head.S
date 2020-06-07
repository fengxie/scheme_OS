
#include <kscm/config.h>
	
.text
	
.globl	_start, KSCM_IDT, KSCM_GDT, KSCM_PAGE_DIR, print_reg32
KSCM_PAGE_DIR:	
_start:	
	cld
	/* reload all segment selector */
	mov	$0x10, %ax
	mov	%ax, %ds
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs

	/* setup stack */
	movl	$K_CODE_SIZE, %esp
	/*
	 * I'm so faint about this problem which boring
	 * me several days. Now I know it is all because
	 * `ld' use a none-zero address for start address
	 * lgdt use the absolute address.
	 */
	call	setup_idt
	call	setup_gdt

	/*
	 * before enter C program, I must set data
	 * segment to stack segment to let the code
	 * work correctly.
	 */
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

	jmp	after_page_table

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

setup_idt:
        lea ignore_int,%edx
        movl $0x00080000,%eax
        movw %dx,%ax            /* selector = 0x0008 = cs */
        movw $0x8E00,%dx        /* interrupt gate - dpl=0, present */

        lea KSCM_IDT,%edi
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

/* End of page dir */
	.org 0x1000
pg0:
	.org 0x2000

after_page_table:
	/* Use last 4k page as initial stack page.
	 * It will be copy to right place when paging is
	 * enabled */
	movl	$K_CODE_SIZE, %esp
	movl	$K_CODE_SIZE, %ebp

	call	setup_paging

	call	main
/*
        pushl $shut_down_msg
        call printk
        popl %eax
*/
	hlt
	/*
end_loop:
	jmp	end_loop*/

shut_down_msg:
	.asciz "\n\rhalt system...\n\r\0"

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
        call printf
        popl %eax
        pop %fs
        pop %es
        pop %ds
        popl %edx
        popl %ecx
        popl %eax
        iret

	.align 2
/*
 * setup_mtrr
 *
 * setup memory mapped I/O
 */
setup_mtrr:
	xorl %edx, %edx
	xorl %eax, %eax
	movl $IA32_MTRR_FIX64K_00000, %ecx
	wrmsr
	movl $IA32_MTRR_FIX16K_80000, %ecx
	wrmsr
	movl $IA32_MTRR_FIX16K_A0000, %ecx
	wrmsr
	
	ret
/*
 * Setup_paging
 *
 * This routine sets up paging by setting the page bit
 * in cr0. The page tables are set up, identity-mapping
 * the first 4MB. 
 *
 */
	.align 2
setup_paging:
	/* initialize all page */
	movl $0x0 + 0x87, KSCM_PAGE_DIR
	movl $0x400000 + 0x87, KSCM_PAGE_DIR + 4

	/*
	movl $1, %eax
	cpuid
	movl %edx, %eax
	call print_reg32
	*/
	/* Set PSE in cr4 for 4MB page */
	movl %cr4, %eax
	orl  $0x10, %eax
	movl %eax, %cr4

	/* pg_dir is at 0x0000 */
	movl $KSCM_PAGE_DIR, %eax
	movl %eax,%cr3		/* cr3 - page directory start */
	movl %cr0,%eax
	orl  $0x80000000,%eax
	movl %eax,%cr0		/* set paging (PG) bit */

	/* move the first 4M page at 0x0 to the page from 0x40000000(4M) */
	pushl %edi
	pushl %esi
	movl $0x400000, %ecx
	movl $0, %esi
	movl $0x400000, %edi
	cld
	rep
	movsb
	popl %esi
	popl %edi

	movl $PGDIR_PADDR, %eax
	movl %eax, %cr3 
	
	/* I have changed the cr3 yet, but the page dir still make
	 * the linear address 0x0 mapped into physical address 0x0.
	 * It should point to 4m, and now linear address 0x400000 is
	 * the real location of the page dir. */
	movl $0x400000 + 0x87, 0x400000
	movl $0x0 + 0x97, KSCM_PAGE_DIR + 4

	/* force TLBs to be reloaded */
	movl $PGDIR_PADDR, %eax
	movl %eax, %cr3 

	ret			/* this also flushes prefetch-queue */

	.align 2
	.word 0
idt_descr:
	.word 256*8-1		# idt contains 256 entries
	.long KSCM_IDT
	
	.align 2
	.word 0
gdt_descr:
	.word 256*8-1		# so does gdt (not that that's any
	.long KSCM_GDT		# magic number, but it works for me :^)

	.align 2
KSCM_IDT:
	.fill 256,8,0			/* idt is uninitialized */	

KSCM_GDT:
	.quad 0x0000000000000000	/* NULL descriptor */
	.quad 0x00cf9a000000ffff	/* 2Gb */
	.quad 0x00cf92000000ffff	/* 2Gb */
	.quad 0x0000000000000000	/* TEMPORARY - don't use */
	.fill 251,8,0			/* space for LDT's and TSS's etc */
