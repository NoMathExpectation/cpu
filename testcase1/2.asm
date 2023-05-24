.data

.text
start:
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