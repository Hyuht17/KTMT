.data
Me1: .asciiz "The sum of "
Me2: .asciiz " and "
Me3: .asciiz " is " 
.text
	addi $s0, $zero, 2 #s0 = 2
	addi $s1, $zero, 3 #s1 = 3
 	li $v0, 4 
 	la $a0, Me1 # in chuoi the sum of truoc
 	syscall
 	li $v0, 1 
 	add $a0,$zero, $s0 #in gia tri cua s0
 	syscall
 	li $v0, 4 
 	la $a0, Me2 # in chuoi and
 	syscall
 	li $v0, 1 
 	la $a0, ($s1) #in gia tri cua s1
 	syscall
 	li $v0, 4 
 	la $a0, Me3 # in chuoi is
 	syscall
 	add $s2, $s0, $s1 # s2 = s1 + s0
 	li $v0, 1 
 	la $a0, ($s2) #in gia tri cua s2 =  s1 + s0
 	syscall