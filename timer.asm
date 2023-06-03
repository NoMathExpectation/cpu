.data 0x0

.text 0x0
start:
#read num
addi $v0, $zero, 5
syscall

add $a1, $zero, $v0

loop:
#sub1 and show
beq $a1, $zero, end
addi $v0, $zero, 1
addi $a1, $a1, -1
add $a0, $zero, $a1
syscall

#sleep
addi $v0, $zero, 32
addi $a0, $zero, 1
syscall
j loop

end:
j start