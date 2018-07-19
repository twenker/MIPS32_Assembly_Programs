#################################################
## Project 1
## Problem 4: Recursion
## Desc: Write a program in MIPS Assembly Language 
## to find fix(i, x), where fix(i, x) is defined 
## recursively as:
## int fix (int i, int x) // assume i > 0, x > 0 {
## 	if (x>0)
##		return fix(i,x-1)+1;
##	else if (i>0)
##		return fix(i-1, i-1)+5;
##	else
##		return 1;
## }
#################################################
#		    DATA
#################################################
.data 

string1:	.asciiz		"Enter an integer i: "
string2:	.asciiz		"Enter an integer x: "

#################################################
#		    TEXT
#################################################
.text

main:
	la $a0, string1
	li $v0, 4
	syscall				# prints the string "Enter an integer i:"
	
	li $v0, 5
	syscall				# reads the user input and places it into $v0 register
	move $s0, $v0			# $s0 is equal to i
	
	la $a0, string2
	li $v0, 4
	syscall				# Prints the string "Enter an integer x:"

	li $v0, 5
	syscall				# reads the user input and places it into the $v0 register
	move $s1, $v0			# $s1 is equal to x
	
	move $a0, $s0			# $a0 = i  
	move $a1, $s1			# $a1 = x
	jal fixStart			# calls the fixStart function
	
	move $a0, $v0			# move the return value into argument register $a0
	li $v0, 1			
	syscall				# prints the return value
	
	li $v0, 10
	syscall				# exit the program
	
#################################################
#		    FUNCTIONS
#################################################

## int fix (int i, int x) // assume i > 0, x > 0 {
## 	if (x>0)
##		return fix(i,x-1)+1;
##	else if (i>0)
##		return fix(i-1, i-1)+5;
##	else
##		return 1;
## }

fixStart:
	# $a0 = i, $a1 = x
	bgtz $a1, xGreaterThan		# branch if x is greater than 0
	bgtz $a0, iGreaterThan		# branch if i is greater than 0
	
	li $v0, 1			# if both x and i are greater than 0, return 1
	
	jr $ra				# if both x and i are less than or equal to 0, then the function returns

xGreaterThan:
	# save the $ra register before the recursion

	addi $sp, $sp, -4		# subtracts 4 from the stack pointer, which is space for a single word
	sw $ra, 0($sp)			# stores the return address on the stack
	
	addi $a1, $a1, -1		# subtracts 1 from x
	jal fixStart			# the recursion: calls fix(i,x-1)
	
	addi $v0, $v0, 1		# adds 1 to the return of fix(i, x-1)
	
	# extracts the return address and removes the stack used
	lw $ra, 0($sp)			# loads the return address from the stack
	addi $sp, $sp, 4		# adds four to the stack to get rid of the stack space no longer needed
	
	jr $ra				# returns the function
iGreaterThan:
	# save the $ra register before the recursion

	addi $sp, $sp, -4		# subtracts 4 from the stack pointer, which is space for a single word
	sw $ra, 0($sp)			# stores the return address
	
	addi $a1, $a1, -1		# subtracts 1 from x
	addi $a0, $a0, -1		# subtracts 1 from i
	jal fixStart			# the recursion: calls fix(i-1,x-1)
	
	addi $v0, $v0, 5		# adds 5 to the return value of fix(i-1, x-1)
	
	# extracts the return address and removes the stack used
	lw $ra, 0($sp)			# loads the return address from the stack
	addi $sp, $sp, 4		# adds four to the stack to get rid of the stack space no longer needed
	
	jr $ra				# returns the function



