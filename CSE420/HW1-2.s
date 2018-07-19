#################################################
## Project 1
## Problem 2: Arithmetic expressions
## Desc: To return the result of 10u^2 + 4uv + v^2 - 1
## where u and v are inputs by the user.
#################################################
#		    DATA
#################################################
.data

string1:	.asciiz		"Enter an integer for value u:"
string2:	.asciiz		"Enter an integer for value v:"
string3:	.asciiz		"10u^2 + 4uv + v^2 - 1"
string4:	.asciiz		" = "

#################################################
#		    TEXT
#################################################
.text

main:
	la $a0, string3		# places the address of string3 into argument register $a0
	li $v0, 4		# places the system code for print string into $v0
	syscall			# prints string 3
	
	li $a0, 10		# loads value of the ascii newline character into $a0
	li $v0, 11		# loads the system code for print character
	syscall			# prints a newline character
	
	la $a0, string1		# places the address of string1 into $a0
	li $v0, 4		# system code for print string
	syscall			# prints string 1
	
	li $v0, 5		# 5 is the code for read int
	syscall
	move $s0, $v0		# places the integer, now called 'u', into $s0
	
	la $a0, string2
	li $v0, 4
	syscall			# prints string 2
	
	li $v0, 5
	syscall
	move $s1, $v0		# places the integer, now called 'v', into $s1
	
#################################	10u^2 + 4uv + v^2 - 1 Calculation
				
	move $a0, $s0		# place u into the argument register
	jal squared		# calls the squared function
	move $s2, $v0		# places the return of squared ($v0) into $s2
	
	addi $a0, $zero, 10	# places the immediate value 10 into argument register $a0
	move $a1, $s2		# places the u^2 into the second argument register $a1
	jal multiply		# calls the multiply function
	move $s2, $v0		# moves the return from multiply into $s2. $s2 = 10u^2
	
	move $a0, $s0		# moves u into the argument register $a0
	move $a1, $s1		# moves v into the argument register $a1
	jal multiply		# calls the multiply function so multiply u and v
	move $a0, $v0		# moves the u*v result into argument register $a0
	addi $a1, $zero, 4	# places the immediate 4 into the argument register into $a1
	jal multiply		# calls multiply on 4 and u*v
	move $s3, $v0		# moves the 4*u*v into $s3
	
	add $s2, $s2, $s3	# adds 10u^2 and 4uv together and places the result into $s2
	
	move $a0, $s1		# moves v into argument register register $a0
	jal squared		# calls squared function on argument v
	add $s2, $s2, $v0	# adds the return value of squared with the sum in $s2. The result is 10u^v+4uv+v^2
	
	subi $s2, $s2, 1	# subtracts 1 from 10u^2+4uv+v^2 and stored the result into $s2
	
#################################	10u^2 + 4uv + v^2 - 1 Calculation Done
	
	la $a0, string3
	li $v0, 4
	syscall			# prints string3
	
	la $a0, string4
	li $v0, 4
	syscall			# prints string4
	
	move $a0, $s2		# moves $s2 into $a0
	li $v0, 1		# system call code for print int
	syscall			# prints $s2
	
	li $v0, 10
	syscall


# Squared function. Takes the argument stored in $a0 and multiplies it by itself and returns the result in $v0
squared:
	move $t0, $a0		# copies the argument in $a0 into $t0
	mult $t0, $a0		# multiplies the contents of $t0 and $a0 and places the result in the LO register
	mflo $v0		# takes the value in the LO register and places it into $v0, the return value
	jr $ra			# jumps and returns
	
multiply:
	mult $a0, $a1		# multiplies the two arguments together and places the result in the LO register
	mflo $v0		# moves the mult result into the return register $v0
	jr $ra			# jumps and returns

	
	
	
	
	
