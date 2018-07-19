# FILE: hw04-02.s
#
# DESCRIPTION
# Recieves an integer and returns whether it is even or odd, -9999 to quit
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
n:		.space 4 # location of memory to store the integer input
str1:		.asciiz "Enter an integer(-9999 to quit): " # the first string asking for an input
str2:		.asciiz " is even." # the second string printed after n if it is even
str3:		.asciiz " is odd." # the second string printed after n if it is odd
#===========================================================
#		TEXT
#===========================================================
.text
startLoop:
li $v0, 4
la $a0, str1
syscall # prints str1

li $v0, 5
syscall # reads user input
add $t0, $v0, $zero # places input into $t0
sw $t0, n # stores #t0 into n

# if andi sets $t1 to 0, then the last bit of n was a 0, meaning that n is even. If $t1 is set to 1, then the final
# bit was a 1, meaning that n is odd.
andi $t1, $t0, 1
beq $t0, -9999, endLoop
beq $t1, $zero, isEven 

isOdd: 
li $v0, 1
add $a0, $t0, $zero
syscall # prints the $t0 register which contains n

li $v0, 4
la $a0, str3
syscall # prints str2\

j startLoop

isEven:
li $v0, 1
add $a0, $t0, $zero
syscall # prints the $t0 register which contains n

li $v0, 4
la $a0, str2
syscall # prints str2

j startLoop

endLoop:
li   $v0, 10     
move $a0, $s6     
syscall # close file
