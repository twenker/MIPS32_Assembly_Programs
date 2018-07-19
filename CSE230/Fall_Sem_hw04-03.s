# FILE: hw04-03.s
#
# DESCRIPTION
# Recieves an integer and returns the sum of all the squares up to that integer
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
str1:		.asciiz "Enter an integer (>0): " # The string that prompts user input
str2:		.asciiz "The sum of the first " # The string before the sum output
str3:		.asciiz " positive integers is: " # the string after the sum output
#===========================================================
#		TEXT
#===========================================================
.text
li $v0, 4
la $a0, str1
syscall # prints str1

li $v0, 5
syscall # reads user input
add $t0, $v0, $zero # places input into $t0 and $s0
add $s0, $v0, $zero 

startLoop:
beq $t0, 0, endLoop

mult $t0, $t0 # equivalent to $t0^2
mflo $t1 # moves $t0^2 to $t1 
add $t2, $t2, $t1 # equivalent to sum += $t0^2
addi $t0, $t0, -1 # subract 1 from $t0
j startLoop 

endLoop:
li $v0, 4
la $a0, str2
syscall # prints str2

li $v0, 1
add $a0, $s0, $zero
syscall # prints the $s0 which is the input value

li $v0, 4
la $a0, str3
syscall # prints str3

li $v0, 1
add $a0, $t2, $zero
syscall # prints the $t2 which is the sum value

li   $v0, 10     
move $a0, $s6     
syscall # close file






