.data
	A: .word -6,9,3,-20,6
.text
main:
	la $a0, A
	li $s0, 5 # $s0 = n
	li $t0, 1 #i = 1;
for1: 	
		beq $t0, $s0, end # i < n
		#key = arr[i]
		sll $t2, $t0, 2 # $t2 = 4 * i
		add $t2, $a0, $t2 # $t2 = địa chỉ A[i]
		lw $s2, ($t2)     #$t2 = A[i]
		add $s1, $s2, $zero  #$s1 = key = $s2
		addi $t1, $t0, -1  #j = i - 1
		sll $t3, $t1, 2 #$t3 = 4 * j
		add $t3, $a0, $t3 #$t3 = địa chỉ A[j]
		lw $s3, ($t3)   #$s3 = a[j]
		
while1: 	
		#j >= 0 && arr[j] > key
		bltz $t1, update
		ble $s3, $s1, update
		#arr[j+1] = arr[j]
		addi $t5, $t1, 1 #$t5 = j + 1
		sll $t5, $t5, 2 #$t5 = 4 * (j + 1)
		add $t5, $a0, $t5 #$t5 = địa chỉ a[j+1]
		add $t6, $t1, $zero #$t6 = j
		sll $t6, $t6, 2 #$t6 = 4 * j
		add $t6, $a0, $t6 #$t6 = địa chỉ a[j]
		lw $s6, ($t6)      #$s6 = a[j]
		sw $s6, ($t5)
		#j = j - 1
		addi $t1, $t1, -1
		sll $t3, $t1, 2 #$t3 = 4 * j
		add $t3, $a0, $t3 #$t3 = địa chỉ A[j]
		lw $s3, ($t3)   #$s3 = a[j]
		j while1

update: 
	#arr[j+1] = key
	addi $t4, $t1, 1 #$t4 = j + 1
	sll $t4, $t4, 2  #$t4 = 4 * (j + 1)
	add $t4, $a0, $t4 #$t4 = địa chỉ a[j+1]
	sw $s1, ($t4)   #arr[j+1] = key
update_i: 
	  addi $t0, $t0, 1
	  j for1
end:
