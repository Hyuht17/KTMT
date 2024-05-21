.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #sử dụng màu đỏ và trắng
.eqv WHITE 0x00FFFFFF
.text
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
 	li $v0, 5
 	syscall
 	add $s0, $v0, $zero #đọc x1 vào s0
 	
 	li $v0, 5
 	syscall
 	add $s1, $v0, $zero #đọc y1 vào s1
 	
 	li $v0, 5
 	syscall
 	add $s2, $v0, $zero #đọc x2 vào s2
 	
 	li $v0, 5
 	syscall
 	add $s3, $v0, $zero #đọc y2 vào s3
 	
 	addi $t0, $s1, 0 #i = y1 
 	addi $t1, $s0, 0 # j = x1
 	addi $t0, $t0, -1 #i = y1 - 1 
	loop:
		bgt $t1, $s2, end
		bne $t5, $zero, to_mau
		addi $t1, $t1, 1
		j loop2
			
to_mau:
	sll $t3, $t0, 3
	add $t2, $t1, $t3 
	sll $t2, $t2, 2
	add $t2, $k0, $t2
	li $t4, RED
	sw $t4, 0($t2)
	j continue
end:	
	