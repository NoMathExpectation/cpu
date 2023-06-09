.data
.text
start:
nop
jal a
j end
a:
addi $v0, $zero, 1
add $a0, $zero, $ra
syscall
jr $ra
end:
addi $v0, $zero, 32
addi $a0, $zero, 5000
syscall


