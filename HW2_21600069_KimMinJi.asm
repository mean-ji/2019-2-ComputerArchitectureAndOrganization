.data
digit:   .word 10, 12, 23, 28, 7, 39, 10, 11, 23, 12, 3, 4, 5, 1, 34, 17, 0, 5, 24
length:   .word 19 # the length of the digit list
buffer: .space 20
str1: .asciiz "\nEnter string(s-Sum/x-Max/n-Min/q-Quit): "
sumResult: .asciiz "\nSum is "
maxResult: .asciiz "\nMax is "
minResult: .asciiz "\nMin is "
sum: .byte 's'
max: .byte 'x'
min: .byte 'n'
quit: .byte 'q'

.text


main:

# HERE, implement mips code
# to get the sum, max, and min of the ‘digit’ list above
# and to print the results (sum, max, and min)

# the printing format should be as follows:
# sum is xxx
# max is yyy
# min is zzz



lb $s4, sum
lb $s5, max
lb $s6, min
lb $s7, quit

Loop:

la $a0, str1
li $v0, 4
syscall

li $v0, 12
syscall

beq $v0, $s4, Sum
beq $v0, $s5, Max
beq $v0, $s6, Min
beq $v0, $s7, Quit

j Loop

Sum:
move $a1, $zero #i = 0
lw $s3, length
la $a0, digit
move $t1, $zero
move $t2, $zero
move $t3, $zero
sumLoop:
beq $a1, $s3, sumPrint
sll $t1, $a1, 2
add $t1, $t1, $a0
lw $t2, 0($t1)
add $t3, $t3, $t2
addi $a1, $a1, 1
j sumLoop

sumPrint:
la $a0, sumResult
li $v0, 4
syscall

li $v0, 1
move $a0, $t3
syscall
j Loop


Max:
move $a1, $zero
move $t3, $zero
lw $s3, length
la $a0, digit
maxLoop:
beq $a1, $s3, maxPrint
sll $t1, $a1, 2
add $t1, $t1, $a0
lw $t2, 0($t1)
slt $t0, $t2, $t3
addi $a1, $a1, 1
bne $t0, $zero, maxLoop
add $t3, $t2, $zero
j maxLoop

maxPrint:
la $a0, maxResult
li $v0, 4
syscall

li $v0, 1
move $a0, $t3
syscall

j Loop


Min:
move $a1, $zero
beq $a1, $s3, minPrint
sll $t1, $a1, 2
add $t1, $t1, $a0
lw $t2, 0($t1)
move $t3, $t2
lw $s3, length
la $a0, digit
minLoop:
beq $a1, $s3, minPrint
sll $t1, $a1, 2
add $t1, $t1, $a0
lw $t2, 0($t1)
slt $t0, $t2, $t3
addi $a1, $a1, 1
beq $t0, $zero, minLoop
add $t3, $t2, $zero
j minLoop

minPrint:
la $a0, minResult
li $v0, 4
syscall

li $v0, 1
move $a0, $t3
syscall

j Loop


Quit:
li $v0, 10
syscall




.end
