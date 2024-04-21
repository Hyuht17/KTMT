.data
	a: .word 1000
	mes1: .asciiz "nhap n:"
	mes2: .asciiz "nhap m:"
.text
	li $v0, 5
	syscall
	addi $s0, $v0, 0 #n = v0 la số phần tử
	la $s1, a #s1 = a
scan:
	li $t0, 0 # i = 0
	for:
		sll $t1, $t0, 2 #t1 = i * 4 
		add $t1, $t1, $s1 #lấy địa chỉ của A[i]
		li $v0, 5
		syscall
		addi $t2, $v0, 0 #gán số đã nhập bằng t2
		sw $t2, 0($t1) # a[i] = t2
		addi $t0, $t0, 1 #i = i + 1
		bge $t0, $s0, scan_m_n #neu doc hết số phần tử thì rẽ nhánh để giải
		j for
scan_m_n:
	#đọc m
	li $v0, 5
	syscall
	addi $s4, $v0, 0 #n = s3
	
	#đọc n
	li $v0, 5
	syscall
	addi $s3, $v0, 0 #m = s4
	
solve:
	li $t0, 0#i = 0
	li $s2, 0#dem = 0
	for1:
		sll $t1, $t0, 2 #t1 = i * 4 
		add $t1, $t1, $s1 #lấy địa chỉ của A[i]
		lw $t2, 0($t1) # a[i] = t2
		slt $t3, $t2, $s3 # t3 = a[i] < n
		slt $t4, $s4, $t2 # t3 = a[i] > m
		and $t3, $t3, $t4 #t3 = t3 and t4
		bne $t3, $zero, tangdem #in ra neu thoa man 2 dieu kien 
		continue:
		addi $t0, $t0, 1 #i = i + 1
		bge $t0, $s0, print_res #neu doc hết số phần tử thì rẽ nhánh để giải
		j for1
tangdem:
	addi $s2, $s2, 1#dem = dem + 1
	j continue
print_res:
	li $v0, 1
	addi $a0, $s2, 0
	syscall
		
		
			
				
					
						
							
								
									
										
											
												
													
														
																
