# FILE: hw04-04.s
#
# DESCRIPTION
# recieves a string of chars and calculates the checksum and the twos complement
#
# AUTHOR(S)
# Todd Wenker (toddwenker@gmail.com)
#===========================================================
#		DATA
#===========================================================
.include "system.inc"

.data
buffer:		.space 1024 # char buffer[1024]
str1:		.asciiz "Enter a String: "
str2:		.asciiz "checksum = "
str3:		.asciiz "two's complement of checksum "
#===========================================================
#		TEXT
#===========================================================
.text

prs(str1) # prints str1
li $v0, 8
la $a0, buffer # sets the address of buffer to $a0
addi $a1, $zero, 1023 # sets the buffer size to 1023
syscall # equivalent to ReadString(&buffer,1023)

la    $s0, buffer # $s0 is set to buffer address
add   $s1, $zero, $zero # offset set to 0

startLoop:
add $s2, $s0, $s1 # adds the offset and buffer address together
lbu $t0, 0($s2) # loads the next byte into $t0

beq $t0, 10, endLoop # if $t0 = '\n' then end loop

add $s3, $s3, $t0 # the char at the offset is set added to the checksum ($s3)
andi $s3, $s3, 0xFF # equivalent to (checksum + ch) modulo 256
addi $s1, $s1, 1 # increment offset by 1

j startLoop # continue loop
endLoop:
xor $s4, $s3, 0xFF # performs the 'not' function on checksum and places it in twos_comp
addi $s4, $s4, 1 # finishes twos_comp operation by adding 1
andi $s4, $s4, 0xFF
prs(str2) # prints str2
prn($s3) # prints checksum
prs(str3) # prints str3
prn($s4) # prints twos_comp
exit












