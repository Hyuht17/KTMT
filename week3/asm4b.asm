.text
	li $s1, 1 #i = 1
	li $s2, 2  #j = 2
	li $s6, 3 # m = 3
	li $s7, 4# n = 4
	start:
		add $t4, $s1, $s2 # t4 = i + j
		add $t5, $s6, $s7 # t5 = m + n 
		slt $t0,$t5, $t4 # t0 = i + j > m + n ? 1 : 0
		beq $t0,$zero,else # re nhanh den to else neu i + j <= m + n
		addi $t1,$t1,1 # then part: x=x+1
		addi $t3,$zero,1 # z=1
		j endif # skip “else” part
	else: 	addi $t2,$t2,-1 # begin else part: y=y-1
		add $t3,$t3,$t3 # z=2*z
	endif: 