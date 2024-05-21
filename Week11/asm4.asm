.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ? # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do # Auto clear after sw
.text
li $k0, KEY_CODE
li $k1, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY

li $s2, 0	# $s2 check 'e'
li $s3, 0	# $s3 check 'x'
li $s4, 0	# $4 check 'i'
li $s5, 0	# $s5 check 't'

loop: nop
WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
nop
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop
#-----------------------------------------------------
ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
nop
#-----------------------------------------------------
WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
nop
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
nop
#-----------------------------------------------------
Encrypt: #check str="exit" and $t0 
	add $s6, $t0, $zero # $s6 = $t0 ban dau
	checklowercase:	sge $t3, $t0, 65
			sle $t4, $t0, 90
			and $t3, $t3, $t4 	# $t3 = (65 <= $t0 <= 90)
			beqz $t3, checkuppercase
			addi $t0, $t0, 32
			j ShowKey
			
	checkuppercase:	sge $t4, $t0, 97
			sle $t5, $t0, 122
			and $t4, $t4, $t5	# $t4 = (97 <= $t0 <= 122)
			beqz $t4, checknumber
			addi $t0, $t0, -32
			j ShowKey
			
	checknumber:	sge $t5, $t0, 48
			sle $t6, $t0, 57
			and $t5, $t5, $t6	# $t5 = (48 <= $t0 <= 57)
			beqz $t5, checkother
			add $t0, $t0, $zero
			j ShowKey
			
	checkother:	addi $t0, $zero, 42

#-----------------------------------------------------
	ShowKey: sw $t0, 0($s0) # show key
	nop

#-----------------------------------------------------

check_e:
	seq $t3, $s6, 101
	beqz $t3, check_x	# if(c == 'e')
	addi $s2, $s2, 1
	j check_exit
	
check_x:
	seq $t3, $s6, 120
	seq $t4, $s2, 1
	and $t3, $t3, $t4
	beqz $t3, check_i	# else if(e == 1 && c == 'x')
	li $s3, 1
	j check_exit
	
check_i:
	seq $t3, $s6, 105
	seq $t4, $s3, 1
	and $t3, $t3, $t4
	beqz $t3, check_t	# else if(x == 1 && c == 'i')
	li $s4, 1
	j check_exit
	
check_t:
	seq $t3, $s6, 116
	seq $t4, $s4, 1
	and $t3, $t3, $t4
	beqz $t3, is_not_exit	# else if(i == 1 && c == 't')
	li $s5, 1
	j check_exit

is_not_exit: #reset
	li $s2, 0	# $s2 check 'e'
	li $s3, 0	# $s3 check 'x'
	li $s4, 0	# $4 check 'i'
	li $s5, 0	# $s5 check 't'
	
check_exit:
	seq $t3, $s2, 1
	seq $t4, $s3, 1
	seq $t5, $s4, 1
	seq $t6, $s5, 1
	and $t3, $t3, $t4
	and $t3, $t3, $t5
	and $t3, $t3, $t6	# $t3 =  if(e == 1 && x == 1 && i == 1 && t == 1)
	beqz $t3, loop
		
exit:	li $v0, 10
	syscall
