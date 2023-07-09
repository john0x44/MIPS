#	Name: TestStack
#	Copyright: 2023
#	Author: John
#	Date: 27/06/23 19:39
#	Description: Utilzing stack pointer 
.data 
input: .asciiz "Please enter 10 numbers\n"
inputNumber: .asciiz "Please input a number: "
output: .asciiz "The sum of the numbers is: "

.align 2 
numbers: .space 40 

.text

#load some values 
li $s0, 10
la $s1, numbers 
li $v0, 4 
la $a0, input
syscall 
b getInputLoop 
getInputLoop:
beqz $s0, loadStack
li $v0, 4 
la $a0, inputNumber
syscall 
li $v0, 5 
syscall 
sw $v0, ($s1) 
addi $s1, $s1, 4
addi $s0, $s0, -1 
b getInputLoop 

#store into stack
loadStack: 
li $s0, 10 
la $s1, numbers 
addi $sp, $sp, -12
sw $s0, 0($sp) 
sw $s1, 4($sp) 
jal sumFunc 
lw $s2, 8($sp) 
addi $sp, $sp, 12 
b outputSum 

outputSum:
li $v0, 4 
la $a0, output 
syscall 
li $v0, 1
move $a0, $s2
syscall
li $v0, 10
syscall 

sumFunc: 
lw $t0, 0($sp) 
lw $t1, 4($sp) 
li $t2, 0
li $t3, 0 
b addLoop 

addLoop: 
beqz $t0, return 
lw $t2, ($t1) 
add $t3, $t3, $t2 
addi $t1, $t1, 4 
addi $t0, $t0, -1
b addLoop 

return: 
sw $t3, 8($sp) 
jr $ra 
