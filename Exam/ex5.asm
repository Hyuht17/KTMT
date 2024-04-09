.data
	mes1: .asciiz"la so may man"
	mes2: .asciiz"ko la so may man"
	a: .word 100
.text
	li $v0, 5 # đọc giá trị của so n vao v0
	syscall
	add $s0, $zero, $v0 # s0 = n
	jal solve
	nop
	beq $s5, $s6, print_true # kiem tra xem tong dau cuoi co bang nhau hay khong
	j print_false
print_true:
	li $v0, 4
	la $a0, mes1
	syscall
	j end
print_false:
	li $v0, 4
	la $a0, mes2
	syscall
end:
	li $v0, 10
	syscall
solve:	
	li $s1, 10 #gan s1 = 10
	li $s2, -1 #i = -1
	la $t6, a 
	while:
		slt $t0, $zero, $s0 #$t0 = $s0 > 0
		bne $t0, $zero, do # neu s0 > 0 thì rẽ nhánh đến do
		j sum
	do:
	        addi $s2, $s2, 1 #i = i + 1
		div $s0, $s1 # chia s0 voi s1
		mflo $s0 # s0 = s0 / 10 
		mfhi $t1 #lay du gan vao t1
		sll $t2, $s2, 2 #i = i * 4
		add $t2, $t2, $t6 # load dia chi 
		sw $t1, 0($t2) #gan gia tri du t1 = a[i]
		j while
	sum:
		li $s1, 2 # s1 = 2
		div $s2, $s1
		mflo $s0 
		beqz $s0, print_false
		li $s5, 0 #sum1 = 0
		li $s6, 0 #sum2 = 0
		li $s3, 0 #j = 0
		addi $s2, $s2, 1 # i = i + 1
		srl $s4, $s2, 1 # s4 = i / 2
		loop:
			slt $t0, $s3, $s4 #t0 = j < i / 2
			bne $t0, $zero, sum1 #neu j < i / 2
		sum2:
			addi $t3, $s3, 0 #t3 = j
			sll $t3, $t3, 2 # t4 = t4 * 4
			add $t3, $t3, $t6 # load giá trị của dịa chỉ a[j]
			lw $t4, 0($t3) #t4 = a[j]
			add $s6, $s6, $t4 #sum2 = sum2 + a[j]
			addi $s3, $s3, 1 # j = j + 1
			slt $t0, $s3, $s2 #t0 = j < i
			bne $t0, $zero, sum2 #neu j < i thi lap
			j done
		sum1:
			addi $t3, $s3, 0 #t3 = j
			sll $t3, $t3, 2 # t4 = t4 * 4
			add $t3, $t3, $t6 # load giá trị của dịa chỉ a[j]
			lw $t4, 0($t3) #t4 = a[j]
			add $s5, $s5, $t4 #sum1 = sum1 + a[j]
			addi $s3, $s3, 1 # j = j + 1
			j loop
	done:
		jr $ra
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		