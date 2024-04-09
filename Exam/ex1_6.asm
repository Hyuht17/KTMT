.data
	a: .word 50
.text
	li $v0, 5 # đọc giá trị của so n vao v0
	syscall
	add $s0, $zero, $v0 # s0 = n
	jal solve
	nop
	add $t3, $zero, $s2 #j = i
print:
	li $v0, 1
	sll $t4, $t3, 2 #t4 = j * 3
	add $t4, $t4, $t6 # load dia chi cua a len t4
	lw $a0, 0($t4) # in ra gia tri cua a[j]
	syscall 
	addi $t3, $t3, -1 #j = j - 1
	bgez $t3, print
end:
	li $v0, 10
	syscall
solve:	
	li $s1, 8 #gan s1 = 10
	li $s2, -1 #i = -1
	la $t6, a 
	while:
		slt $t0, $zero, $s0 #$t0 = $s0 > 0
		bne $t0, $zero, do # neu s0 > 0 thì rẽ nhánh đến do
		j done
	do:
	        addi $s2, $s2, 1 #i = i + 1
		div $s0, $s1 # chia s0 voi s1
		mflo $s0 # s0 = s0 / 10 
		mfhi $t1 #lay du gan vao t1
		sll $t2, $s2, 2 #i = i * 4
		add $t2, $t2, $t6 # load dia chi 
		sw $t1, 0($t2) #gan gia tri du t1 = a[i]
		j while
	done:
		jr $ra
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		