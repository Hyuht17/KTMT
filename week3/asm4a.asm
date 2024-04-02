.text
	li $s1, 1 #i = 1
	li $s2, 2  #j = 2
	start:
		slt $t0,$s1,$s2 # t0 = j > i ? 1 : 0
		beq $t0,$zero,else # re nhanh den to else neu j=<i
		addi $t1,$t1,1 # then part: x=x+1
		addi $t3,$zero,1 # z=1
		j endif # skip “else” part
	else: 	addi $t2,$t2,-1 # begin else part: y=y-1
		add $t3,$t3,$t3 # z=2*z
	endif: 