.data 
	string: .space 20
	Me1: .asciiz "Nhap ki tu thu "
	Me2: .asciiz " : "
	Me3: .asciiz "\n"
.text
	li $t0, 0     #i = 0
	la $s0, string  # $s0 = string
	li $s1, 10    #ki tu xuong dong
	input:
		li $v0, 4
		la $a0, Me1
		syscall
		
		li $v0, 1
		addi $a0, $t0, 1
		syscall 
		
		li $v0, 4
		la $a0, Me2
		syscall
		
		#nhap ki tu
		li $v0, 12
		syscall
		
		add $t1, $t0, $s0
		sb $v0, 0($t1)
		#kiem tra xem co phai la ki tu enter hay khong
		beq $v0, $s1, printstring
		
		li $v0, 4
		la $a0, Me3
		syscall
		
		addi $t0, $t0, 1 # i = i + 1
		
		#kiem tra dieu kien do dai > 20 hay chua
		slti $t3, $t0, 20 #nếu $t0 > 19 -> 4t3 = 0
		beqz $t3, printstring
		j input
		
	printstring:
		li $v0, 11
		lb $a0, 0($t1)
		syscall
		addi $t1, $t1, -1
		blt $t1, $s0, end
		j printstring
	end:
		
		
	