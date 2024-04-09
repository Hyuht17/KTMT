.data
	st: .space 256
	a: .word 1024
.text
	li $v0, 8
	la $a0, st
	li $a1, 256
	syscall
	
	li $v0, 12
 	syscall 
	
	addi $t8, $v0, 0
	addi $t9, $t8, -32
	la $s0, st
	li $t3, 0
	li $t0, -1 #i = 0
	li $s5, 10 
solve:
	
	lb $s6, 0($s0)
	beq $s6, $s5, done #neu gap kí tự kết thúc xâu thì done
	
	beq $s6, $t8, tang_dem1 
	continue1:
	beq $s6, $t9, tang_dem2
	continue2:
	

	addi $s0, $s0, 1# i = i + 1
	j solve
tang_dem1:
	addi $t3, $t3, 1
	j continue1
tang_dem2:
	addi $t3, $t3, 1
	j continue2
done:
	li $v0, 1
	addi $a0, $t3, 0
	syscall 