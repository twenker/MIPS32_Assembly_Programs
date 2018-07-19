#################################################
## Project 1
## Problem 3: Pointers
## Desc: To calculate the sum of the elements in 
##	an array
#################################################
#		    DATA
#################################################
.data 

# the array name is attached to a block of 40 bytes, enough space for the 10 int array that will be made later in the 
#	program
array: 		.space		40
string: 	.asciiz		"Sum of the Array = "
#################################################
#		    TEXT
#################################################
##int sum = 0; int *sump = &sum; int a[10];
##void PSum(int *s, int *e)
##{
##	*s += *e; }
##int main() {
##	for (int i=0; i<10; i++) {
##		a[i] = 3(i+1); }
##	for (int i=0; i<10; i++) {
##		PSum(sump, a+i); }
##	printf( sum = %d\n , sum); }
.text

main:
	la $s0, array			# loads the address of our array
	li $s1, 0			# $s1 is equivalent to i
	li $s2, 10			# $s2 acts as the check so 
	
ArrayLoop:
	beq $s1, $s2, ArrayLoopEnd	
	
	addi $a0, $s1, 1		# places (i+1) into argument register
	li $a1, 3			# places 3 into argument register
	jal multiply			# calls multiply on 3 and (i+1)
	move $t0, $v0
	sw $t0, 0($s0)			# stores 3(i+1) into position i in the array
	
	addi $s0, $s0, 4		# adjusts the address in $s0 so it points to the next location
	addi $s1, $s1, 1		# i++
	
	j ArrayLoop
	
	
ArrayLoopEnd:
	la $a0, array			# places the array address into the 
	jal PSum			# calls PSum
	move $t0, $v0			# moves the return value from PSum into $t0
	
	la $a0, string
	li $v0, 4
	syscall				# prints string
	
	move $a0, $t0			# moves the result from the PSum into the $a0
	li $v0, 1			# system code for print int
	syscall				# prints PSum
	
	li $v0, 10			# exits the program
	syscall

#################################	Functions

PSum:	
	# takes the address of the array as an argument and returns the sum
	li $t0, 10			# $t0 is equal to i (for the array index)
	add $v0, $zero, $zero		# sets the $v0 register to zero
	
SumLoop:
	beq $t0, $zero, SumLoopEnd	# ends the loop if the index register is at 0
	lw $t1, 0($a0)			# loads the value at the address stored in $a0
	add $v0, $v0, $t1		# adds the loaded word into the return return register
	addi $a0, $a0, 4		# adjusts the address stored in the argument register to point to the next value
	addi $t0, $t0, -1		# adjusts $t0, the register storing the index of the array
	j SumLoop			# continues the loop
SumLoopEnd:
	jr $ra				# returns to the program



multiply:
	mult $a0, $a1			# multiplies the two arguments together and places the result in the LO register
	mflo $v0			# moves the mult result into the return register $v0
	jr $ra				# jumps and returns






