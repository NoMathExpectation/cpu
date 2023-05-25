.data

.text
start:
	read:
	li $v0, 5
	syscall
	
	move $t0, $sp
	push:
	beqz $v0, pull
	sub $sp, $sp, 4
	sw $v0, ($sp)
	addi $t1, $t1, 1
	subi $v0, $v0, 1
	b push
	
	pull:
	bleu $t0, $sp, end
	lw $v0, ($sp)
	addi $sp, $sp, 4
	addi $t1, $t1, 1
	add $t2, $t2, $v0
	b pull
	
	end:
	li $v0, 1
	move $a0, $t2
	syscall