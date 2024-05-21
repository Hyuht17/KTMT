.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.data
	mes: .asciiz "Nhap ki tu:"
	a: .word 0x3f, 0x6, 0x5B, 0x4F, 0x66, 0xED, 0x7d, 0x7, 0x7f, 0x67
.text
main:
	#hiển thị nhập số
	li $v0, 4
	la $a0, mes
	syscall
	
	#đọc giá trị
	li $v0, 12
	syscall
  	#lay 2 số cuối của số vừa nhập 
  	li $s0, 10
  	div $v0, $s0 # chia lay dư cho 10 ta được những số ở cuối
  	mfhi $t1 # lấy dư là số cuối 
  	mflo $v0 # lấy thương vào v0
  	div $v0, $s0
  	mfhi $t2 # lấy dư là số tiếp theo 
	nop
#hàm gán giá trị để hiển thị 2 số cuối
gan_gia_tri:
	la $s1, a #s1 = a
	sll $t1, $t1 , 2 # t1 = t1 * 4
	add $t1, $s1, $t1 #truy nhập đến địa chỉ của s1 
	lw $a0, 0($t1) #gán giá trị cho a0 để hiển thị
 	jal SHOW_7SEG_RIGHT # show
 	nop
 	
 	sll $t2, $t2 , 2 # t2 = t2 * 4
	add $t2, $s1, $t2 #truy nhập đến địa chỉ của s1 
	lw $a0, 0($t2) #gán giá trị cho a0 để hiển thị
 	jal SHOW_7SEG_LEFT # show
 	nop
exit: 
	li $v0, 10
 	syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT # assign port's address
 	sb $a0, 0($t0) # assign new value
 	nop
 	jr $ra
 	nop

#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT # assign port's address
 	sb $a0, 0($t0) # assign new value
 	nop
 	jr $ra
 	nop 

