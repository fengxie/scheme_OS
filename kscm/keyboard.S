# 1 "keyboard.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "keyboard.S"

# 2 "keyboard.S" 2

.globl key_map, shift_map, alt_map
	
# 55 "keyboard.S"

key_map:
	.byte 0,27
	.ascii "1234567890-="
	.byte 127,9
	.ascii "qwertyuiop[]"
	.byte 13,0
	.ascii "asdfghjkl;'"
	.byte '`,0
	.ascii "\\zxcvbnm,./"
	.byte 0,'*,0,32		/* 36-39 */
	.fill 16,1,0		
	.byte '-,0,0,0,'+	
	.byte 0,0,0,0,0,0,0	
	.byte '<
	.fill 10,1,0

shift_map:
	.byte 0,27
	.ascii "!@#$%^&*()_+"
	.byte 127,9
	.ascii "QWERTYUIOP{}"
	.byte 13,0
	.ascii "ASDFGHJKL:\""
	.byte '~,0
	.ascii "|ZXCVBNM<>?"
	.byte 0,'*,0,32		/* 36-39 */
	.fill 16,1,0		
	.byte '-,0,0,0,'+	
	.byte 0,0,0,0,0,0,0	
	.byte '>
	.fill 10,1,0

alt_map:
	.byte 0,0
	.ascii "\0@\0$\0\0{[]}\\\0"
	.byte 0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0
	.byte '~,13,0
	.byte 0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0		
	.fill 16,1,0		
	.byte 0,0,0,0,0		

