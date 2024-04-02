.text
	addi $s1, $zero, 100
	addi $s0, $zero, 200
ExtracMSB:
	srl $t1, $s0, 24 # dich phai 24 bit 
ClearLSB:
	andi $s0, $s0, 0xFFFFFF00 # and 8 bit cuoi voi 0 
SetLSB:
	ori $s0, $s0, 0x000000ff # or 8 bit cuoi voi 1 de set 
Clear:
	xor $s0, $s0, $s0 # xor s0 với chính nó de S0 = 0 
