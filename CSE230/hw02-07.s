# FILE: hw02-07.s
#
# DESCRIPTION:
# Creates 2 structers with ints named x, y, and z and then finds
# the dot product.
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.data
point1:		.space 12 # point1 is a structure that contains 3 ints: x, y, z
point2:		.space 12 # point2 is a structure that contains 3 ints: x, y, z
str1:		.asciiz "Enter x: " 
str2:		.asciiz "Enter y: "
str3:		.asciiz "Enter z: "
str4:		.asciiz "The dot product is: " 
#===========================================================
#		TEXT
#===========================================================
.text
#===========================================================
#		point1 inputs
#===========================================================
li $v0, 4
la $a0, str1
syscall # prints str1

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point1 #loads address of point1 into $t1
sw $t0, 0($t1) # stores $t0 into point1.x

li $v0, 4
la $a0, str2
syscall # prints str2

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point1 #loads address of point1 into $t1
sw $t0, 4($t1) # stores $t0 into point1.y

li $v0, 4
la $a0, str3
syscall # prints str3

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point1 #loads address of point1 into $t1
sw $t0, 8($t1) # stores $t0 into point1.z
#===========================================================
#		point2 inputs
#===========================================================
li $v0, 4
la $a0, str1
syscall # prints str1

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point2 # loads the address of point2 into $t1
sw $t0, 0($t1) # stores $t0 into point2.x

li $v0, 4
la $a0, str2
syscall # prints str2

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point2 # loads the address of point2 into $t1
sw $t0, 4($t1) # stores $t0 into point2.y

li $v0, 4
la $a0, str3
syscall # prints str3

li $v0, 5
syscall # reads user input 
add $t0, $v0, $zero # the read int is placed into $t0
la $t1, point2 # loads the address of point2 into $t1
sw $t0, 8($t1) # stores $t0 into point2.z
#===========================================================
#		dotproduct 
#===========================================================
la $t9, point1
lw $t0, 0($t9) # loads point1.x into $t0

la $t8, point2
lw $t1, 0($t8) # loads point2.x into $t1

mult $t0, $t1 # multiplies point1.x and point2.x
mflo $s0 # moves point1.x * point2.x from lo register into $s0 register

lw $t0, 4($t9) # loads point1.y into $t0

lw $t1, 4($t8) # loads point2.y into $t1

mult $t0, $t1 # multiplies point1.y and point2.y 
mflo $s1 # moves the product into $s1

lw $t0, 8($t9) # loads point1.z into $t0

lw $t1, 8($t8) # loads point2.z into $t1

mult $t0, $t1 # multiplies point1.z and point2.z
mflo $s2 # moves the product into $s1

add $s0, $s0, $s1
add $s0, $s0, $s2 # adds the three products together to get the final dot product sum

li $v0, 4
la $a0, str3
syscall # prints str3

li $v0, 1
add $a0, $s0, $zero
syscall # prints the $a0 register which contains the dotproduct

li   $v0, 16      
move $a0, $s6     
syscall # close file



