.data
	a: .asciiz " "
.text
	li $v0, 5
	syscall
	addi $s0, $v0, 0 #s = n
	jal solve
	nop
	end:
	#ket thúc chương trình
	li $v0, 10
	syscall
	
solve:
	
	li $t0, 0 #khoi tao gia tri dau tien
	li $t1, 1 #khoi tao gia tri thu 2
	j xu_ly
	continue:
	#in ra 0 và 1 nếu xử lí trường hợp đặc biết xong rồi
	#in 0
	li $v0, 1
	li $a0, 0
	syscall
	
	#in dấu cách
	li $v0, 4
	la $a0, a
	syscall
	#in 1
	li $v0, 1
	li $a0, 1
	syscall
	
	#in dấu cách
	li $v0, 4
	la $a0, a
	syscall  
	
	while:
		add $t2, $t0, $t1 #t3 = tổng của 2 số hạng trước đó
		blt $t2, $s0, do #nếu t3 ( là tổng của 2 số phía trước) < n thì mới làm
		jr $ra
	do:
		li $v0, 1
		add $a0, $t2, $zero #in ra nếu < n
		syscall
		
		#in dấu cách
		li $v0, 4
		la $a0, a
		syscall
		
		addi $t0, $t1, 0 # khởi tạo lại giá trị của số hạng trước đó
		addi $t1, $t2, 0 #khởi tạo lại giá trị của số hạng trước đó
		j while
xu_ly:
	#kiểm tra trường hợp nếu n = 1, n = 0 hoặc n < 0
	beq $s0, $t1, print_0 # kiểm tra nếu n = 1 thì in 0
	ble $s0, $t0, end #kiểm tra n < 0 thì end và không in gì
	j continue
	
print_0: #hàm in giá trị 0
	li $v0, 1
	li $a0, 0
	syscall
	#in dấu cách
	li $v0, 4
	la $a0, a
	syscall
	j end 