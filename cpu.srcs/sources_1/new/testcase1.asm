
.data

.text
start:



case0:
	li $v0, 5
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	beq $a0, 0, end
	
	loop:
	addi $t1, $t1, 1
	bge $t1, 32, end
	
	srl $a0, $a0, 1
	andi $t2, $a0, 1
	beq $t2, 0, loop
	
	bgt $a0, 1, end
	li $t0, 1
	
	end:
	sw $t0, 0

case1:
    li $v0, 5
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	and $t0, $a0, 1
	sw $t0, 0

case2:
    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall

    li $v0, 32
	li $a0, 3000
	syscall
	
	or $t3, $t1, $t2
	
	li $v0, 1
	move $a0, $t3
	syscall

case3:
    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	nor $t3, $t1, $t2
	
	li $v0, 1
	move $a0, $t3
	syscall

case4:
    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	xor $t3, $t1, $t2
	
	li $v0, 1
	move $a0, $t3
	syscall

case5:
    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	slt $t3, $t1, $t2
	
	sw $t3, 0

case6:
    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	sltu $t3, $t1, $t2
	
	sw $t3, 0

case7:

    li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 32
	li $a0, 3000
	syscall