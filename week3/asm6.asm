.data 
	A: .word 1, -10, -3, 4, 2
.text	
		addi $s5, $zero, 0 # max = 0
		addi $s6, $zero, 0 #rs = 0
		addi $s1, $zero, 0 # i = 0
		addi $s4, $zero, 1 # step = 1
		addi $s3, $zero, 5 # n = 5
		la $s2, A # luu gia tri cua mang a len thanh ghi s2
	loop: 	slt $t2, $s1, $s3 # $t2 = i < n ? 1 : 0
		beq $t2, $zero, endloop # re nhanh den endloop neu i >= n
		add $t1, $s1, $s1 # $t1 = 2 * $s1
		add $t1, $t1, $t1 # $t1 = 4 * $s1
		add $t1, $t1, $s2 # $t1 store the address of A[i]
		lw $t0, 0($t1) # load value of A[i] in $t0
		slt $t3, $t0, $zero #t3 = A[i] < 0 ? 1 : 0
		bne $t3, $zero, tuyetdoi #re nhanh den tuyetdoi de tinh gia tri tuyet doi cua so am neu A[i] < 0
		add $t6, $t0, $zero # gan t6 = A[i]
		j tiep # neu khong am thi bo qua tuyetdoi
		tuyetdoi:
			  sub $t6, $zero, $t0 # A[i] = 0 - A[i] de tinh gia tri duong
		tiep:
		slt $t3, $s5, $t6  # t3 = max < |A[i]| ? 1 : 0
		bne $t3, $zero, ganmax # neu max < |A[i]| thi re nhanh den ganmax
		j tiep2 #neu max >= |A[i]| thi khong gan max = |A[i]| nua
		ganmax:
			add $s5, $t6, $zero # max = |A[i]|
			add $s6, $t0, $zero # rs = A[i]
		tiep2:
		add $s1, $s1, $s4 # i = i + step
		j loop # goto loop
	endloop: 
