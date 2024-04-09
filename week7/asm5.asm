.data
	Mes1: .asciiz "Largest:"
	Mes2: .asciiz ","
	Mes3: .asciiz "\nLargest:"
	
.text
main:
# gán giá trị của các than ghi thanh ghi
	li $s0, 1 
	li $s1, 2
	li $s2, 3
	li $s3, 9
	li $s4, 5
	li $s5, -2
	li $s6, -3
	li $s7, 8
	add $t0, $s0, $zero # khoi tao gia tri max bằng 1 phần tử bất kì
	add $t1, $s0, $zero # khoi tao gia tri min bằng 1 phần tử bất kì
	jal solve
	jal print
	li $v0, 10 #thoat
	syscall
end_main:
solve:	
	# lưu giá trị của các thanh ghi vào stack
	addi $sp, $sp, -32 # cấp phát bộ nhớ cho ngăn xếp
	sw $s0, 0($sp) 
	sw $s1, 4($sp) 
	sw $s2, 8($sp) 
	sw $s3, 12($sp) 
	sw $s4, 16($sp) 
	sw $s5, 20($sp) 
	sw $s6, 24($sp) 
	sw $s7, 28($sp) 
	addi $t2, $zero, 1 #i = 1
	addi $t7, $zero, 8 #n = 8
	loop:	
		slt $t6, $t2, $t7 # t6 =  i < n
		beq $t6, $zero, done # neu i >= n thi done
		sll $t3, $t2, 2 #j = i * 4
		add $t4, $sp, $t3 # t4 trỏ đến con trỏ sp + i
		lw $t5, 0($t4) # t5 = s[i]
		slt $t6, $t0, $t5 # t6 = max < s[i]
		bne $t6, $zero, ganmax # if max < s[i] thi gan max
		slt $t6, $t5, $t1 # t6 = s[i] < min
		tiep:
		bne $t6, $zero, ganmin #if s[i] < min thì gán min
		addi $t2, $t2, 1 # i = i + 1
		j loop
	ganmax:
		add $t0, $t5, $zero
		add $t8, $t2, $zero # vi tri max
		j tiep
	ganmin:
		add $t1, $t5, $zero
		add $t9, $t2, $zero # vi tri min
		addi $t2, $t2, 1 # i = i + 1
		j loop
done:
 	jr $ra
print:
	li $v0, 4
	la $a0, Mes1
	syscall
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	li $v0, 4
	la $a0, Mes2
	syscall
	li $v0, 1
	add $a0, $t8, $zero
	syscall
	li $v0, 4
	la $a0, Mes3
	syscall
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	li $v0, 4
	la $a0, Mes2
	syscall
	li $v0, 1
	add $a0, $t9, $zero
	syscall
	jr $ra		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	