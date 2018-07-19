#***************************************************************************************************
# FILE: hw03-03.s
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
TWO_TO_31_MINUS_1:	.word 2147483647	# TWO_TO_31_MINUS_1 = 0x7FFF_FFFF
x:		.space 68 			# x[17] = {0}
a:		.word 1947			# a = 1947
b:		.word 1111			# b = 1111
m:		.word 32707			# m = 32707
seed:		.word 1792			# seed = 1792
t:		.word 0				# t = 0
#===========================================================
#		TEXT
#===========================================================
.text
# loading the variables from memory
la $t0, TWO_TO_31_MINUS_1
lw $s0, 0($t0)			# $s0 = TWO_TO_31_MINUS_1

la $t0, a
lw $s1, 0($t0)			# $s1 = a

la $t0, b
lw $s2, 0($t0)			# $s2 = b

la $t0, m
lw $s3, 0($t0)			# $s3 = m

la $t0, seed
lw $s4, 0($t0)			# $s4 = seed

la $t0, t
lw $s5, 0($t0)			# $s5 = t

la $s6, x			# $s6 = &x

li $t0, 16			# i = $t0 = 16
li $t1, 1			# j = $t1 = 1
li $t2, 23			# $t2 = 23

# the two for loops

loop1_start:
beq $t0, $zero, loop1_end	# when i = 0, the loop ends

mul $t3, $t0, 4			# $t3 = 4*i which will form the offset
add $t3, $s6, $t3		# $t3 = offset + &x
add $t4, $zero, $zero		# $t4 = x[i] = 0
sw $t4, 0($t3)			# storing x[i] = 0 back in the array

loop2_start:
beq $t1, $t2, loop2_end		# when j = 23, the inner loop ends

subu $s5, $s1, $s4		# t = a - seed

div $t4, $t4, 2			# $t4 = x[i] /= 2
sw $t4, 0($t3)			# stores x[i] /= 2

# if statement 

bge $s5, $zero, if_end		# if t > 0, then the if statement is false

addu $t4, $t4, $s0		# $t4 = x[i] += TWO_TO_31_MINUS_1 
sw $t4, 0($t3)			# stores x[i] += TWO_TO_31_MINUS_1 

addu $s5, $s5, $s3		# t += m
if_end:

move $s4, $s2			# seed = b
move $s2, $s1			# b = a
move $s1, $s5			# a = t

addi $t1, $t1, 1		# j++
j loop2_start			# continues loop2
loop2_end:
# Printing x[i], char ' ', and i--
li $v0, 1		# $v0 = PrintInt() system code
move $a0, $t4		# $a0 = int to be printed
syscall			# Call PrintInt()

li $a0, ' '		# loads char ' ' into $a0
li $v0, 11    		# prints char in $a0
syscall

addi $t0, $t0, -1		# i--
j loop1_start			# continues loop1
loop1_end:

# Exit Program
li $v0, 10		# %v0 = Exit() system code
syscall			# Call Exit()




