.text
	addi $s0, $zero, 10 #s0 = 10	
	addi $s1, $zero, 8 #s1 = 1
	addi $t1, $zero, 1 #t1
loop:
	beq $s1, $t1, exit # neu s1 = 1 thi thoat chuong trinh
	sll $s0, $s0, 1 #dich trai 1 bit de nhan s0 voi 2
	srl $s1, $s1, 1	#dich phai 1 bit de chia s1 cho 2
	j loop # lap
exit: