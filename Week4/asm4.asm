.text
	addi $s1, $zero, -2147483647 # s1 = 4
	addi $s2, $zero, -5 #s2 = 5
start:
	li $t0,0 #No Overflow is default status
	addu $s3,$s1,$s2 # s3 = s1 + s2
	xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
	bltz $t1,EXIT #If not, exit
	xor $t1, $s1, $s3 # kiem tra xem s1 voi s2 voi s3 co cung dau hay khong
	bltz $t1, OVERFLOW  #neu s3 va s1 s2 khac dau thi overflow
	j EXIT
OVERFLOW:
	li $t0,1 #the result is overflow
EXIT: