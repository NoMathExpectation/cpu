.data

.text
start:
	read:
	li $v0, 5
	syscall
	
	li $t0, 0
	bge $v0, 0, calc
	
	li $v0, 32
	li $a0, 500
	invalid_loop:
	addi $t0, $t0, 1
	bgt $t0, 3, read
	
	li $t1, 1
	sw $t1, 0
	syscall
	
	li $t1, 0
	sw $t1, 0
	syscall
	
	b invalid_loop
	
	calc:
	add $t0, $t0, $v0
	subi $v0, $v0, 1
	bgt $v0, 0, calc
	
	li $v0, 1
	move $a0, $t0
	syscall