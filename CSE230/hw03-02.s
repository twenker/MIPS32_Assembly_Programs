#***************************************************************************************************
# FILE: hw03-02.s
#
# DESCRIPTION:
# To recieve an integer input n and return n / 2 if even and 3n+1 if odd.
#
# AUTHOR
# Todd Wenker (toddwenker@gmail.com)
#***************************************************************************************************
#===========================================================
#		DATA
#===========================================================
.data 
str1:		.asciiz "Enter n (>= 1) " 			# The first string to be printed
str2:		.asciiz "\nThe total stopping time is: "	# The second string to be printed
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
move $s0, $v0		# $s0 = n

# setting 'stop' to 0 and printing n

li $s1, 0		# stop = $s1 = 0

li $v0, 1		# $v0 = PrintInt() system code
move $a0, $s0		# $a0 = int to be printed
syscall			# Call PrintInt()

li $a0, ' '		# loads char ' ' into $a0
li $v0, 11    		# prints char in $a0
syscall

# Loop

li $t0, 1		# $t0 = 1
loop_start:
beq $s0, $t0, loop_end	# if n = 1, then the loop ends

and $t1, $s0, $t0	# compares the first bit of n with 1. If the result is 0, then its even, otherwise its odd
beq $t1, $zero, if_even # if $t1 equals 0, then n is even 

if_odd:
mul $s0, $s0, 3		# n = 3n
addi $s0, $s0, 1	# n = 3n +1
j if_end		# jump to the if end section

if_even:
div $s0, $s0, 2		# n = n/2

if_end:
addi $s1, $s1, 1	# stop +=

li $v0, 1		# $v0 = PrintInt() system code
move $a0, $s0		# $a0 = int to be printed
syscall			# Call PrintInt()

li $a0, ' '		# loads char ' ' into $a0
li $v0, 11    		# prints char in $a0
syscall

j loop_start		# continue the loop
loop_end:

# printing str2 and the integer stop

li $v0, 4		# $v0 = PrintString() system code
la $a0, str2		# $a0 = addr of str1
syscall			# Call PrintString()

li $v0, 1		# $v0 = PrintInt() system code
move $a0, $s1		# $a0 = int to be printed
syscall			# Call PrintInt()

# Exit Program
li $v0, 10		# %v0 = Exit() system code
syscall			# Call Exit()



