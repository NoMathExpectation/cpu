.data

.text
start:
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