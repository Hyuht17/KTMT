.data 
S: .word 1, 4, 2, 5, 3
.text
main: 
	la $a0,S
 	li $a1,5
 	j mspfx
 	nop
end_of_main:
