#################################################
## Project 1
## Problem 1: String Handling
## Desc: To turn an upper case string declared in 
## 	the data section into a lower case string
#################################################
#		    DATA
#################################################
.data 

string: 	.asciiz		"WELCOME TO COMPUTER ARCHITECTURE CLASS"
 
#################################################
#		    TEXT
#################################################
.text

main:
	la $t0, string 		# $t0 now holds the address of the start of 'string'
	li $t2, 32		# places the immediate 32 into $t2. This is the ASCII value of a space
loop:
	lb $t1, 0($t0) 		# $t1 now holds the byte at the address of $t0
	beq $t1, $zero, end	# if $t1 is equal to 0, then the string has ended the program should jump to 'end'
	beq $t1, $t2, update	# if #t1 is equal to 32, the ASCII value of a space, then we dont need to make it lower case
	addi $t1, $t1, 32	# adds 32 (0x20) to the value in $t1
	sb $t1, 0($t0)		# stores the updated $t1 into the original memory
update:
	addi $t0, $t0, 1	# adds 1 to $t0 so that the next lb instruction loads the next character
	j loop
	
end:
	la $a0, string 		# places the address of 'string' into the argument register $a0
	li $v0, 4 		# places the system code 4 into $v0 to print the string at the address in $a0
	syscall			# prints the updated string
	
	li $v0, 10		# place the exit code, 10, into $v0 to end the program
	syscall






