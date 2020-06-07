# 1 "boot/head.S"
# 1 "<command-line>"
# 1 "boot/head.S"


# 1 "include/kscm/config.h" 1

# 34 "include/kscm/config.h"















# 57 "include/kscm/config.h"









































# 109 "include/kscm/config.h"



# 3 "boot/head.S" 2
	
.text
	
.globl	_start, G_idt, G_gdt, G_page_dir, print_reg32
G_page_dir:	
_start:	
	cld
	
	mov	$0x10, %ax
	mov	%ax, %ds
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs

	
	movl	$0x400000, %esp
	





	call	setup_idt
	call	setup_gdt

	




	mov	$0x10, %eax
	mov	%ax, %ds
	mov	%ax, %ss	
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs

	
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
        movw %dx,%ax            
        movw $0x8E00,%dx        

        lea G_idt,%edi
        mov $256,%ecx
	
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


	.org 0x1000
pg0:
	.org 0x2000

after_page_table:
	


	movl	$0x400000, %esp
	movl	$0x400000, %ebp

	call	setup_paging

	call	main





	hlt
	



shut_down_msg:
	.asciz "\n\rhalt system...\n\r\0"


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





setup_mtrr:
	xorl %edx, %edx
	xorl %eax, %eax
	movl $0x250, %ecx
	wrmsr
	movl $0x258, %ecx
	wrmsr
	movl $0x259, %ecx
	wrmsr
	
	ret








	.align 2
setup_paging:
	
	movl $0x0 + 0x87, G_page_dir
	movl $0x400000 + 0x87, G_page_dir + 4

	





	
	movl %cr4, %eax
	orl  $0x10, %eax
	movl %eax, %cr4

	
	movl $G_page_dir, %eax
	movl %eax,%cr3		
	movl %cr0,%eax
	orl  $0x80000000,%eax
	movl %eax,%cr0		

	
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

	movl $(0x400000), %eax
	movl %eax, %cr3 
	
	



	movl $0x400000 + 0x87, 0x400000
	movl $0x0 + 0x97, G_page_dir + 4

	
	movl $(0x400000), %eax
	movl %eax, %cr3 

	ret			

	.align 2
	.word 0
idt_descr:
	.word 256*8-1		# idt contains 256 entries
	.long G_idt
	
	.align 2
	.word 0
gdt_descr:
	.word 256*8-1		# so does gdt (not that that's any
	.long G_gdt		# magic number, but it works for me :^)

	.align 2
G_idt:
	.fill 256,8,0				

G_gdt:
	.quad 0x0000000000000000	
	.quad 0x00cf9a000000ffff	
	.quad 0x00cf92000000ffff	
	.quad 0x0000000000000000	
	.fill 251,8,0			
