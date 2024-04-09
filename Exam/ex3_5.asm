.data
    s1: .space 256        # Buffer cho xâu s1
    s2: .space 256        # Buffer cho xâu s2
    msg_prompt: .asciiz "Nhap vao xau s1: "
    msg_prompt2: .asciiz "Nhap vao xau s2: "
    result_match: .asciiz "Hai xau giong nhau."
    result_not_match: .asciiz "Hai xau khong giong nhau."

.text
    # Nhập xâu s1 từ người dùng
    li $v0, 4
    la $a0, msg_prompt
    syscall

    li $v0, 8
    la $a0, s1
    li $a1, 255
    syscall

    # Nhập xâu s2 từ người dùng
    li $v0, 4
    la $a0, msg_prompt2
    syscall

    li $v0, 8
    la $a0, s2
    li $a1, 255
    syscall

    # So sánh 2 xâu
    la $t0, s1       # Con trỏ tới xâu s1
    la $t1, s2       # Con trỏ tới xâu s2

compare_loop:
    lb $t2, ($t0)    # Load ký tự từ xâu s1
    lb $t3, ($t1)    # Load ký tự từ xâu s2
    beq $t2, $zero, end_compare    # Kết thúc nếu gặp ký tự null trong s1
    beq $t3, $zero, end_compare    # Kết thúc nếu gặp ký tự null trong s2

    # Chuyển ký tự s1 và s2 về cùng một dạng (in thường)
    li $t4, 'A'      # 'A' trong ASCII
    li $t5, 'Z'      # 'Z' trong ASCII
    blt $t2, $t4, not_upper_s1    # Kiểm tra xem ký tự trong s1 có phải là chữ hoa không
    bgt $t2, $t5, not_upper_s1    # Kiểm tra xem ký tự trong s1 có phải là chữ hoa không
    addi $t2, $t2, 32              # Chuyển đổi chữ hoa thành chữ thường
not_upper_s1:
    blt $t3, $t4, not_upper_s2    # Kiểm tra xem ký tự trong s2 có phải là chữ hoa không
    bgt $t3, $t5, not_upper_s2    # Kiểm tra xem ký tự trong s2 có phải là chữ hoa không
    addi $t3, $t3, 32              # Chuyển đổi chữ hoa thành chữ thường
not_upper_s2:

    bne $t2, $t3, not_match    # Nếu ký tự trong s1 và s2 khác nhau, không giống nhau
    addi $t0, $t0, 1            # Tiếp tục với ký tự tiếp theo trong s1
    addi $t1, $t1, 1            # Tiếp tục với ký tự tiếp theo trong s2
    j compare_loop

not_match:
    # In ra hai xâu không giống nhau
    li $v0, 4
    la $a0, result_not_match
    syscall
    j end_program

end_compare:
    # Nếu đã duyệt hết cả hai xâu và không có sự khác biệt nào, in ra hai xâu giống nhau
    li $v0, 4
    la $a0, result_match
    syscall

end_program:
    # Kết thúc chương trình
    li $v0, 10
    syscall
