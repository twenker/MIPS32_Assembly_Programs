#***************************************************************************************************
# FILE: hw03-01.s
#
# DESCRIPTION:
# To recieve an integer input and then return (1^3 - 1) + (2^3 - 2) + ... (n^3 - n). 
#
# AUTHOR
# Todd Wenker (toddwenker@gmail.com)
#***************************************************************************************************
#===========================================================
#		DATA
#===========================================================
.data 
str1:		.asciiz "Enter n (>= 1) " 	# The first string to be printed
str2:		.asciiz "Result = "	   	# The second string to be printed
#===========================================================
#		TEXT
#===========================================================
.text
# printing str1 and receiving input n

li $v0, 4		# $v0 = PrintString() system code
la $a0, str1		# $a0 = addr of str1
syscall			# Call PrintString()

li $v0, 5		# $v0 = ReadInt() system call
syscall			# $v0 = Call ReadInt()
move $s0, $v0		# $s0 = Readint()

# loop

add $s1, $s1, $zero	# sum = $s1 = 0
addi $s2, $s2, 1	# i = $s2 = 1
loop_start:
bgt $s2, $s0, loop_end	# if i ($s2) is > n ($s0), then end the loop

mul $t0, $s2, $s2 	# $t0 = i^2
mul $t0, $t0, $s2	# $t0 = i^2 * i = i^3
sub $t0, $t0, $s2	# $t0 = i^3 - i
add $s1, $s1, $t0	# sum = sum + (i^3 - i)
addi $s2, $s2, 1	# i++

j loop_start		# restart loop 
loop_end:

# Printing str2 and integer sum 

li $v0, 4		# $v0 = PrintString() system code
la $a0, str2		# $a0 = addr of str1
syscall			# Call PrintString()

li $v0, 1		# $v0 = PrintInt() system code
move $a0, $s1		# $a0 = int to be printed
syscall			# Call PrintInt()

# Exit Program
li $v0, 10		# %v0 = Exit() system code
syscall			# Call Exit()