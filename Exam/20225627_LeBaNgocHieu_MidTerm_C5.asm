.data
    	s1: .space 256        # xâu s1
    	s2: .space 256        # xâu s2
   	giong_nhau: .asciiz "Hai xau giong nhau."
    	khac_nhau: .asciiz "Hai xau khong giong nhau."

.text
   	li $v0, 8 #hàm nhập xâu s1
    	la $a0, s1
    	li $a1, 256
    	syscall

    	li $v0, 8 #Nhập xâu s2
    	la $a0, s2
    	li $a1, 256
    	syscall
    	
    	li $t2, 'A'      # lấy vị trí của kí tự 'A' trong ASCII 
    	li $t3, 'Z'      # lấy vị trí của kí tự 'Z' trong ASCII
    	
    	jal solve
    	nop
    	#ket thuc chuong trinh
    	li $v0, 10
    	syscall 

solve:

    	la $s0, s1       # $s0 = s1
    	la $s1, s2       # $s1 = s2

	loop:
    		lb $t0, 0($s0)    # Load ký tự từ xâu s1
    		lb $t1, 0($s1)    # Load ký tự từ xâu s2
    		beq $t0, $zero, end    # Kết thúc nếu gặp ký tự null trong s1
    		beq $t1, $zero, end    # Kết thúc nếu gặp ký tự null trong s2

    		# Chuyển ký tự s1 và s2 về cùng in thường
    		
    		blt $t0, $t2, ngoai_AZ_1    # Kiểm tra xem ký tự trong s1 có < 'A' hay không
    		bgt $t0, $t3, ngoai_AZ_1    # Kiểm tra xem ký tự trong s1 có > 'Z' hay không
    		addi $t0, $t0, 32              # Chuyển đổi chữ hoa thành chữ thường
    		
	ngoai_AZ_1:
    		blt $t1, $t2, ngoai_AZ_2    # Kiểm tra xem ký tự trong s1 có < 'A' hay không
    		bgt $t1, $t3, ngoai_AZ_2    # Kiểm tra xem ký tự trong s1 có > 'Z' hay không
    		addi $t1, $t1, 32              # Chuyển đổi chữ hoa thành chữ thường
	ngoai_AZ_2:
    		bne $t0, $t1, khong_giong_nhau    # Nếu ký tự trong s1 và s2 khác nhau thì in
    		addi $s0, $s0, 1        	# Truy cập kí tự tiếp theo trong s1
    		addi $s1, $s1, 1            	# Truy cập kí tự tiếp theo trong s2
    		j loop

khong_giong_nhau:
    	# In ra hai xâu không giống nhau
    	li $v0, 4
    	la $a0, khac_nhau
    	syscall
    	jr $ra

end:
    	# Nếu da duyet het thi in ra hai xâu giống nhau
    	li $v0, 4
    	la $a0, giong_nhau
    	syscall
    	jr $ra

