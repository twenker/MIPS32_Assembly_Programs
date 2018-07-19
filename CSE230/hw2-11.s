# FILE: hw2-11.s
#
# DESCRIPTION
# Recieves two integers and ouputs 2 times their sum
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
a:	.word 0 # initialize a to 0
b:	.word 0 # initialize b to 0
c:	.word 0 # initialize c to 0
str1:	.asciiz "Enter a: " #sets the first printed string
str2:	.asciiz "Enter b: " #sets the second printed string
str3:	.asciiz "2(a + b) = " #sets the third printed string
#===========================================================
#		TEXT
#===========================================================
.text
 #===========================================================
#		Printing str1
#===========================================================
li $v0, 4
la $a0, str1
syscall # prints str1
#===========================================================
#		Reading and Storing and int to a
#===========================================================
li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is put into $t0
sw $t0, a # stores $t0 into label a
#===========================================================
#		Printing str2
#===========================================================
li $v0, 4
la $a0, str2
syscall # prints str2
#===========================================================
#		Reading and Storing an int to b
#===========================================================
li $v0, 5
syscall # reads user input
add $t0, $v0, $zero # places input into $t0
sw $t0, b # stores #t0 into b
#===========================================================
#		Performing the 2(a+b) Operation
#===========================================================
lw $t0, a # places a into $t0
lw $t1, b # places b into $t1
add $t0, $t0, $t1
add $t0, $t0, $t0 # performs the function 2(a+b)
sw $t0, c # stores $t0 into c
#===========================================================
#		Printing str3
#===========================================================
li $v0, 4
la $a0, str3
syscall # prints str3
#===========================================================
#		Printing c
#===========================================================
li $v0, 1
add $a0, $t0, $zero
syscall # prints the $a0 register which contains c
#===========================================================
#		Close file
#===========================================================
li   $v0, 10      
move $a0, $s6     
syscall # close file



