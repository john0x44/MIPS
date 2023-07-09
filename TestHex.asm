#
#	Name: TestHex
#	Copyright: 2023
#	Author: John 
#	Date: 23/04/23 10:24
#	Description: Get hex of a non-negative number
#
.data
prompt: .asciiz "Please enter a non-negative integer number: "
hexBuffer: .asciiz "0x00000000"
output: .asciiz "Hex: "
.text
 li $v0, 4
 la $a0, prompt
 syscall

 li $v0, 5
 syscall
 move $a0, $v0

 b processHex

processHex:
 la $t2, hexBuffer
 addi $t2, $t2, 9 #end of buffer or &buffer + 9;
 li $t0, 8 #t0 loop counter
 b loopHex
gtb:
 bgtz $t0, loopHex
 b exit


contLoopHex:
 sb $t1, ($t2)
 addi $t0, $t0, -1
 addi $t2, $t2, -1
 b gtb

plus7:
 addi $t1, $t1, 7
 b contLoopHex
#convert to hex
loopHex:
 andi $t1, $a0, 15
 addi $t1, $t1, 48
 srl $a0, $a0, 4 #a0=a0/16 2^4
 bgt $t1, 57, plus7

 b contLoopHex

exit:
 li $v0, 4
 la $a0, output
 syscall
 la $a0, hexBuffer
 syscall
 li $v0, 10
 syscall

 