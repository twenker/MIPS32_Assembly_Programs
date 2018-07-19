#**************************************************************************************************************
# FILE: hw04-05.s
#
# DESCRIPTION
# Computes and displays the n-th Fibonacci number. We define the Fibonacci sequence to be:
#
# f(0) = 0
# f(1) = 1
# f(n) = f(n-2) + f(n-1) when n >= 2
#
# PSEUDOCODE:
# Program hw04-05
#     Function main()
#         Integer n, fib_n
#         PrintString("Enter an integer (>= 0): ")
#         n = ReadInt()
#         fib_n = fibonacci(n)
#         PrintString("f("
#         PrintInt(n)
#         PrintString(") = ")
#         PrintInt(fib_n)
#         Exit()
#     End Function main
#
#     Function fibonacci(Input: n : Integer) Returns Integer
#         Integer fib_n = 0, fib_n_minus2, fib_n_minus_1, i
#         If (n < 2) Then
#             fib_n = n
#         Else
#             fib_n_minus2 = 0
#             fib_n_minus1 = 1
#             For (i = 2; i <= n; ++i)
#                 fib_n = fib_n_minus_2 + fib_n_minus_1
#                 fib_n_minus_2 = fib_n_minus_1
#                 fib_n_minus_1 = fib_n
#             End For
#         End If
#         Return fib_n
#     End Function fibonacci
# End Program hw04-05
#
# AUTHOR
# Kevin Burger (burgerk@asu.edu)
# Computer Science & Engineering
# Arizona State University
#**************************************************************************************************************
.include "system.inc"

.data
s_prompt:    .asciiz  "Enter an integer (>= 0): "
s_msg1:      .asciiz  "fib("
s_msg2:      .asciiz  ") = "

.text
#--------------------------------------------------------------------------------------------------------------
# FUNCTION: main
#
# STACK
# On entry, $sp points to the absolute bottom of the stack, which looks like this,
#
# +---------------+
# |  free mem     | <-- $sp 0x7FFF_EFFC
# +---------------+
# |  free mem     |         0x7FFF_EFF8
# +---------------+
#
# Main does not return so we don't have to save $ra or $fp, but we set up a stack frame to
# allocate room for local variables n and fib_n. The stack frame will look like this,
#
# +---------------+
# |     fib_n     | <-- $fp
# +---------------+
# |       n       | -4($fp) <-- $sp
# +---------------+
# |  free mem     |
# +---------------+
#--------------------------------------------------------------------------------------------------------------
main:
# Create main's stack frame
la $fp, ($sp)                                            # Anchor $fp at bottom of stack (move $sp to $fp)
addi $fp, $fp, -8                                            # Allocate room on stack for n and fib_n (add -8 to $sp)

# PrintString("Enter an integer (>= 0): "
prs(s_prompt)                                            # Use prs macro to display s_prompt

# n = ReadInt()
rdn($t0)                                            # Use rdn macro to read an integer into $t0
sw $t0, -4($fp)                                     # n = ReadInt() (store $t0 at -4 + $fp)

# fibonacci(n)
add $a0, $t0, $zero                                            # $a0 = n
fibonacci($a0)                                            # fibonacci(n) (call fibonacci function)
sw $v0, 0($fp)                                            # fib_n = fibonacci(n) (store $v0 at 0 + $fp)

# PrintString("fib(")
prs(s_msg1)                                            # Use prs macro to display s_msg1

# PrintInt(n)
lw $t0, -4($fp)                                            # $t0 = n (load $t0 from -4 + $fp)
prn($t0)                                            # PrintInt(n) (usr prn macro to display $t0)

# PrintString(") = "
prs(s_msg2)                                            # Use prs macro to display s_msg2

# PrintInt(fib_n)
lw $t0, 0($fp)                                            # $t0 = fib_n (load $t0 from 0 + $fp)
prn($t0)                                            # PrintInt(fib_n) (use prn macro to display $t0)

# Exit()
exit                                 # Terminate the program (use exit macro)

#--------------------------------------------------------------------------------------------------------------
# FUNCTION: fibonacci
#
# DESCRIPTION
# Computes and returns the n-th Fibonacci number.
#
# INPUT PARAMS
# $a0 - n
#
# RETURNS
# $v0 - fib_n
#
# STACK
# On entry, $sp points to the top of the stack which looks like this,
#
# +---------------+
# |  main fib_n   |
# +---------------+
# |   main n      | <-- $sp
# +---------------+
# |  free mem     |
# +---------------+
#
# After saving $ra, $fp, and allocating local variables, fibonacci's stack frame  will look like
# this,
#
# +---------------+
# |  saved $ra    | <-- $fp     20($sp)
# +---------------+
# |  saved $fp    | -4($fp)     16($sp)
# +---------------+
# |    fib_n      | -8($fp)     12($sp)
# +---------------+
# | fib_n_minus_2 | -12($fp)    8($sp)
# +---------------+ 
# | fib_n_minus_1 | -16($fp)    4($sp)
# +---------------+
# |      i        | -20$fp)  <-- $sp
# +---------------+
#--------------------------------------------------------------------------------------------------------------
fibonacci:
# Create stack frame and initialize local variables
addi $sp, $sp, -24                                            # Allocate 6 words on the stack (subtract 24 from $sp)                                            # Save $ra (store $ra at 20 + $sp)
sw $fp, 16($sp)                                            # Save $fp (store $fp at 16 + $sp)
la $fp, 20($fp)                                            # Anchor $fp at bottom of stack frame ($fp <- $sp + 20)
sw $zero, 12($sp)                                            # fib_n = 0 (store 0 at 12 + $sp)

# If (n < 2) fib_n = n
addi $t0, $zero, 2                                            # $t0 = 2 (add $zero and 2)
bge $a0, $t0, false_clause                                            # if n >= 2 goto false_clause (bge if $a0 > $t0)
sw $a0, -8($fp)                                            # fib_n = n (store $a0 at -8 + $fp)
j end_if                                            # Skip over false clause (jump to end_if)

# else ...
# fib_n_minus_2 = 0
false_clause:
sw $zero, -12($fp)                                            # fib_n_minus_2 = 0 (store 0 at -12 + $fp)
addi $t0, $zero, 1                                            # $t0 = 1 (add $zero and 1)
sw $t0, -16($fp)                                            # fib_n_minus_1 = 1 (store $t0 at -16 + $fp)

# fib_n_minus_1 = 1
addi $t1, $t0, 1                                            # $t1 = 2 (add $t0 and 1)
sw $t1, -20($fp)                                            # i = 2 (store $t1 at -20 + $fp)

begin_loop:
j loop_condition                                            # Go check loop condition (jump to loop_condition)

loop_body:
# fib_n = fib_n_minus_2 + fib_n_minus_1
lw $t2, -12($fp)                                            # $t2 = fib_n_minus_2 (load from -12 + $fp)
lw $t1, -16($fp)                                            # $t1 = fib_n_minus_1 (load from -16 + $fp)
add $t3, $t1, $t2                                            # $t3 = fib_n_minus_2 + fib_n_minus_1 (add $t1 and $t2)
sw $t3, -8($fp)                                            # fib_n = fib_n_minus_2 + fib_n_minus_1 (store  $t3 at -8 + $fp)

# fib_n_minus_2 = fib_n_minus_1
sw $t1, -12($fp)                                            # fib_n_minus_2 = fib_n_minus_1 (store $t1 at -12 + $fp)

# fib_n_minus_1 = fib_n
sw $t3, -16($fp)                                            # fib_n_minus_1 = fib_n (store $t3 at -16 + $fp)

# ++i
lw $t0, -20($fp)                                            # $t0 = i (load $t0 from -20 + $fp)
addi $t0, $t0, 1                                            # $t0 = i + 1 (add $t0 and 1)
sw $t0, -20($fp)                                            # ++i (store $t0 at -20 + $fp)

# i <= n ?
loop_condition:
lw $t0, -20($fp)                                            # $t0 = i (load $t0 from -20 + $fp)
ble $t0, $a0, loop_body                                            # if i <= n goto loop_body (ble if $t0 < $a0)
end_if:

# Destroy stack frame and return fib_n
lw $v0, -8($fp)                                           # $v0 = fib_n (load $v0 from -8 + $fp)
lw $ra, 0($fp)                                            # Restore $ra (load $ra from 0 + $fp)
la $fp, -4($fp)                                            # Restore $fp (load $fp from -4 + $fp)
addi $sp, $sp, 24                                            # Destroy stack frame (add 24 to $sp)
jr $ra                                            # Return fib_n








