#***************************************************************************************************
# FILE: hw02-8.s
#
# DESCRIPTION:
# To recieve 2 integers and return 2a^3 + b^2 - 1
#
# AUTHOR
# Todd Wenker (toddwenker@gmail.com)
#***************************************************************************************************
#===========================================================
#		DATA
#===========================================================
.data
a:		.word 0 # set int a = 0
b:		.word 0 # set int b = 0
c:		.word 0 # set int c = 0
str1:		.asciiz "Enter a: " # sets the first string to be printed
str2:		.asciiz "Enter b: " # sets the second string to be printed
str3:		.asciiz "2a^3 + b^2 - 1 = " # sets the third string to be printed
#===========================================================
#		TEXT
#===========================================================
.text

# Print str1 and Store variable a

li $v0, 4	# $v0 = PrintString() system code
la $a0, str1	# $a0 = addr of str1
syscall		# Call PrintString()

li $v0, 5		# $v0 = ReadInt() system call
syscall			# $v0 = Call ReadInt()
move $s0, $v0		# $s0 = Readint()

la $t0, a	# $t0 = addr of global variable a
sw $s0, 0($t0)	# stores $s0 into global variable a

# Print str2 and Store variable b

li $v0, 4	# $v0 = PrintString() system code
la $a0, str2	# $a0 = addr of str1
syscall		# Call PrintString()

li $v0, 5		# $v0 = ReadInt() system call
syscall			# $v0 = Call ReadInt()
move $s0, $v0		# $s0 = Readint()

la $t1, b	# $t1 = addr of global variable b
sw $s0, 0($t1)	# stores $s0 into global variable b

# The Arithmetic Section(2a^3+b^2-1)

lw $s0, 0($t0)	# $s0 = a
lw $s2, 0($t1)	# $s2 = b

mul $s1, $s0, $s0 	# $s1 = a^2
mul $s1, $s1, $s0	# $s1 = (a^2) * a = a^3
sll $s1, $s1, 1		# eqv to (a^3 * 2^1)

mul $s2, $s2, $s2 	# $s2 = b^2

add $s1, $s1, $s2	# $s1 = 2a^3 + b^2
addi $s1, $s1, -1	# $s1 = 2a^3 + b^2 - 1

la $t2, c	# $t2 = addr of c
sw $s1, 0($t2)	# stores $s1 into global variable c

# Printing str3 and global variable c

li $v0, 4	# $v0 = PrintString() system code
la $a0, str3	# $a0 = addr of str3
syscall		# Call PrintString()

li $v0, 1	# $v0 = PrintInt() system code
move $a0, $s1	# $a0 = int to be printed
syscall		# Call PrintInt()

# Exit Program
li $v0, 10	# %v0 = Exit() system code
syscall			# Call Exit()



