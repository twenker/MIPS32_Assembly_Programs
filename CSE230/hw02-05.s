# FILE: hw02-05.s
#
# DESCRIPTION
# Recieves an integer n and prints the number at that fibonacci index
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
n:		.space 4 # global int n implicitly initialized to 0
f:		.word 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610 # int array f as a fibonacci sequence
s_prompt:	.asciiz "Enter n (0 <= n <= 15):" # sets the string s_prompt
s_out1:		.asciiz "f(" # sets the string s_out1
s_out2:		.asciiz ") = " # sets the string s_out2
#===========================================================
#		TEXT
#===========================================================
.text
li $v0, 4
la $a0, s_prompt
syscall # prints s_prompt

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
sw $t0, n # stores $t0 into n

li $v0, 4
la $a0, s_out1
syscall # prints s_out1

li $v0, 1
add $a0, $t0, $zero
syscall # prints n, which was stored in $t0

li $v0, 4
la $a0, s_out2
syscall # prints s_out2

la $t1, f # puts the address of f into $t3
add $t0, $t0, $t0 # double the index of n
add $t0, $t0, $t0 # double the index of n again (4*n)
add $t2, $t0, $t1 # combine the index plus the address of f (4*n + f)
lw $t4, 0($t2) # get the value from the the nth address of f

li $v0, 1
add $a0, $t4, $zero
syscall # prints $t4 which is the nth value from array f

li   $v0, 16      
move $a0, $s6     
syscall # close file












