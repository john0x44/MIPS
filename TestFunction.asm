#	Name: TestFunction
#	Copyright: 2023
#	Author: John
#	Date: 27/06/23 19:39
#	Description: Utilzing function

.data 
output: .asciiz "The sum of the numbers in the array is: "
.align 2 
numbers: .word 1,2,3,4,5,6,7,8,9,10

.text 
la $a0, numbers 
li $a1, 10 
jal sumFunc
move $s0, $v0 
li $v0, 4
la $a0, output
syscall 
li $v0, 1 
move $a0, $s0
syscall 
li $v0, 10 
syscall 

sumFunc: 
move $t0, $a0 
move $t1, $a1 
li $t2, 0 
li $t3, 0 
b addLoop 

addLoop: 
beqz $t1, return 
lw $t2, ($t0)
add $t3, $t3, $t2 
addi $t0, $t0, 4 
addi $t1, $t1, -1 
b addLoop 

return: 
move $v0, $t3
jr $ra 