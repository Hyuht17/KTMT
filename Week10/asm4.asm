.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #sử dụng màu đỏ và trắng
.eqv WHITE 0x00FFFFFF
.text
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
 	li $t0, 0 # i = 0
 	li $t1, -1 # j = -1
 	li $s0, 7
 	li $s1, 2
to_mau:
	bgt $t0, $s0, end # tô chẵn đến ô thứ 62
	xuong_dong:
	addi $t1, $t1, 1 #j = j + 1
	sll $t6, $t0, 3
	add $t2, $t1, $t6
	sll $t2, $t2, 2 # t2 = t0 * 4
	add $t2, $k0, $t2 #truy cập địa chỉ của k[i]
	#chọn màu
	add $t4, $t1, $t0 #t4 = i + j
	div $t4, $s1 #chia j + i cho 2
	mfhi $t4 # dư của phép chia là t4
	beq $t4 , $zero, gan_do#nếu chia hết cho 2 thì gán màu dỏ
	li $t3, WHITE
	continue:
	sw $t3, 0($t2) #luu giá trị màu trắng
	blt $t1, $s0, xuong_dong # nếu đọc đến hết ô thứ 7 thì xuống dòng
	li $t1, -1 #reset lại j
	addi $t0, $t0, 1 #i = i + 1
	j to_mau
gan_do:
	li $t3, RED
	j continue
end:
