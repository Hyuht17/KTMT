#dung keyboard dieu khien marsbot
#Space:	bat dau/dung di chuyen
#W:di len, S: di xuong, A:sang trai, D:sang phai (viet hoa/ thuong deu duoc)

.eqv HEADING 0xffff8010
.eqv MOVING 0xffff8050 
.eqv LEAVETRACK 0xffff8020 
.eqv WHEREX 0xffff8030 
.eqv WHEREY 0xffff8040 

.eqv KEY_CODE 0xFFFF0004 
.eqv KEY_READY 0xFFFF0000 
.eqv DISPLAY_CODE 0xFFFF000C 
.eqv DISPLAY_READY 0xFFFF0008 

.text
li $s6, KEY_CODE
li $s7, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY

li $s2, 0	# $s2 check 'e'
li $s3, 0	# $s3 check 'x'
li $s4, 0	# $4 check 'i'
li $s5, 0	# $s5 check 't'

loop: nop
WaitForKey: lw $t1, 0($s7) # $t1 = [$k1] = KEY_READY
nop
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop

ReadKey: lw $t0, 0($s6) # $t0 = [$k0] = KEY_CODE
nop

WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
nop
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
nop

Encrypt: #check str="exit" and $t0 = mode
	add $t9, $t0, $zero # $t9 = $t0 ban dau
	check_left:	beq $t0, 65, modeA
			beq $t0, 97, modeA
			
	check_right:	beq $t0, 68, modeD
			beq $t0, 100, modeD
			
	check_up:	beq $t0, 87, modeW
			beq $t0, 119, modeW
	
	check_down:	beq $t0, 83, modeS
			beq $t0, 115, modeS
	
	check_move_top:	beq $t0, 32, modeSpace
	
#-----------------------------------------------------
	ShowKey: sw $t0, 0($s0) # show key
		nop
#-----------------------------------------------------
check_e:
	seq $t3, $t9, 101
	beqz $t3, check_x	# if(c == 'e')
	addi $s2, $s2, 1
	j check_exit
	
check_x:
	seq $t3, $t9, 120
	seq $t4, $s2, 1
	and $t3, $t3, $t4
	beqz $t3, check_i	# else if(e == 1 && c == 'x')
	li $s3, 1
	j check_exit
	
check_i:
	seq $t3, $t9, 105
	seq $t4, $s3, 1
	and $t3, $t3, $t4
	beqz $t3, check_t	# else if(x == 1 && c == 'i')
	li $s4, 1
	j check_exit
	
check_t:
	seq $t3, $t9, 116
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
	
modeA:		#di chuyen sang ngang bên trái
	jal UNTRACK
	nop
	jal TRACK
	nop
	addi $a0, $zero, 270
	jal ROTATE
	nop
	jal GO
	nop
	j ShowKey

modeD:		#di chuyen sang ngang bên phải
	jal UNTRACK
	nop
	jal TRACK
	nop
	addi $a0, $zero, 90
	jal ROTATE
	nop 
	jal GO
	nop
	j ShowKey
	
modeW:		#di chuyen len tren thang dung
	jal UNTRACK
	nop
	jal TRACK
	nop
	addi $a0, $zero, 0
	jal ROTATE
	nop
	jal GO
	nop
	j ShowKey

modeS:		#di chuyen xuong duoi thang dung
	jal UNTRACK
	nop
	jal TRACK
	nop
	addi $a0, $zero, 180
	jal ROTATE
	nop
	jal GO
	nop
	j ShowKey	
	
modeSpace:		#di chuyen sang ngang bên phải
	li $at, MOVING
	lw $t8, 0($at)
	beqz $t8, continue 
	jal STOP
	nop
	j ShowKey
continue:
	jal GO
	nop
	j ShowKey
		
GO: 
	li $at, MOVING # change MOVING port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start running
	nop
	jr $ra
	nop

STOP: 
	li $at, MOVING # change MOVING port to 0
	sb $zero, 0($at) # to stop
	nop
	jr $ra
	nop

TRACK: 
	li $at, LEAVETRACK # change LEAVETRACK port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start tracking
	nop
	jr $ra
	nop

UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
	sb $zero, 0($at) # to stop drawing tail
	nop
	jr $ra
	nop

ROTATE: 
	li $at, HEADING # change HEADING port
	sw $a0, 0($at) # to rotate robot
	nop
	jr $ra
	nop
