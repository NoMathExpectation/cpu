.data

.text
start:
	li $v0, 5
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	and $t0, $a0, 1
	sw $t0, 0