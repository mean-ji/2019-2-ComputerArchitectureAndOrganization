.data
matrixA:   .float 1.5, -1.2, 2.3, -2.2, 0.1, 0.3, -2.8, 0.7, 3.9, 1.1, 5.1, -1.6, 1.3, 1.3, 1.4, 2.0, 3.2, -1.2, 1.0, 0.5, -1.2, -0.2, 1.2, 3.9, 2.2, -1.2, -0.3, 1.2, -2.1, 1.8, 1.1, 2.2, -3.1, 0.4, -2.2, 3.2, 0.1, -2.2, -1.3, -0.2, -2.4, 0.8
vectorX:   .float 3.2, -1.5, 1.1, 2.5, 0.3, -2.3
vectorB:   .float 0.3, -0.5, 1.3, -2.1, 0.1, 1.2, -3.3
shapeA:    .word 7, 6 # matrix size is 5 x 3
str1: .asciiz "\nshape\n"  #
str2: .asciiz "\nmatrix elements at (0,0) and (0,1)\n"
str3: .asciiz "\nMax matrix is\n" #
space: .asciiz " "
nextLine: .asciiz "\n"
Zero: .float 0.0
.text
main:
  # print the values of y,
  # where y = max(0, matrixA * vectorX + vectorB)

  li $v0, 4 # system call code for printing string = 4
  la $a0, str1
  syscall # call operating system to perform operation

  # printing shape
  li $v0, 1
  la $s0, shapeA
  lw $a0, 0($s0)
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, space
  syscall # call operating system to perform operation

  li $v0, 1
  lw $a0, 4($s0)
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, str2
  syscall # call operating system to perform operation

  # printing the first two elements
  li $v0, 2
  la $s1, matrixA
  lwc1 $f12, 0($s1)
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, space
  syscall # call operating system to perform operation

  li $v0, 2
  lwc1 $f12, 4($s1)
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, str3
  syscall # call operating system to perform operation


  #Ax+b!!!!
  la $s2, vectorX
  la $s3, vectorB
  lw $t6, 0($s0) #m=5
  lw $a3, 4($s0) #n=3


  move $a1, $zero # matrixA i
  move $t3, $zero # matrixB k

matrixMain:
  beq $t3, $t6, Exit
  move $a2, $zero # vectorX j
  la $s4, Zero
  lwc1 $f4, 0($s4)

Loop1: #Ax
  beq $a3, $a2, Loop2

  sll $t0, $a1, 2
  add $t0, $t0, $s1
  lwc1 $f1, 0($t0)


  sll $t1, $a2, 2
  add $t1, $t1, $s2
  lwc1 $f2, 0($t1)

  mul.s $f3, $f1, $f2
  add.s $f4, $f4, $f3
  addi $a1, $a1, 1 #i++
  addi $a2, $a2, 1 #j++
  j Loop1

Loop2:
  sll $t2, $t3, 2
  add $t2, $t2, $s3
  lwc1 $f5, 0($t2)

  add.s $f6, $f4, $f5

  addi $t3, $t3, 1 #k++

  j Max

Max:
  la $s4, Zero
  lwc1 $f30, 0($s4)
  c.lt.s $f30, $f6
  bc1t maxPrint

  li $v0, 1
  move $a0, $zero
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, nextLine
  syscall # call operating system to perform operation

  j matrixMain

maxPrint:
  la $s4, Zero
  lwc1 $f31, 0($s4)

  li $v0, 2
  add.s $f12, $f6, $f31
  syscall

  li $v0, 4 # system call code for printing string = 4
  la $a0, nextLine
  syscall # call operating system to perform operation

  j matrixMain

Exit:

.end
