# FILE: hw2-13.s
#
# DESCRIPTION
# Recieves two integers and ouputs 2 times their sum
# but with macros!
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
.include "system.inc"

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
prs(str1) # prints str1
#===========================================================
#		Reading and Storing and int to a
#===========================================================
rdn($t0) # the read int is put into $t0
sw $t0, a # stores $t0 into label a
#===========================================================
#		Printing str2
#===========================================================
prs(str2) # prints str2
#===========================================================
#		Reading and Storing an int to b
#===========================================================
rdn($t0) # places input into $t0
sw $t0, b # stores #t0 into b
#===========================================================
#		Performing the 2(a+b) Operation
#===========================================================
lgv($t0, a) # places a into $t0
lgv($t1, b) # places b into $t1
add $t0, $t0, $t1
add $t0, $t0, $t0 # performs the function 2(a+b)
sw $t0, c # stores $t0 into c
#===========================================================
#		Printing str3
#===========================================================
prs(str3) # prints str3
#===========================================================
#		Printing c
#===========================================================
prn($t0) # prints the $a0 register which contains c
#===========================================================
#		Close file
#===========================================================
exit # close file



