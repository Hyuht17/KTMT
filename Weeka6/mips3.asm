
.data
    A: .word -6, 9, 3, 10, -20
    n: .word 5   # Số lượng phần tử trong mảng A
    msg: .asciiz "Array after sorting: "
    sp: .asciiz " "
.text
main:
    la $a0, A      # $a0 = Địa chỉ của A[0]
    lw $s0, n      # $s0 = Số lượng phần tử trong mảng A
    addi $s0, $s0, -1  # $s0 = n - 1, vì chỉ số bắt đầu từ 0

    # In mảng ban đầu
    li $v0, 4      # syscall 4: in chuỗi
    la $a0, msg    # $a0 = Địa chỉ của chuỗi msg
    syscall

    li $v0, 1      # syscall 1: in số nguyên
    la $a0, A      # $a0 = Địa chỉ của A[0]
    li $t0, 0      # $t0 = 0 (i = 0)

print_loop:
    lw $a1, 0($a0)  # $a1 = A[i]
    move $a0, $a1   # Di chuyển giá trị của A[i] vào $a0 để in ra
    syscall

    # In dấu phẩy và khoảng trắng
    li $v0, 4      # syscall 4: in chuỗi
    la $a0, sp   # $a0 = Địa chỉ của chuỗi ", "
    syscall

    addi $t0, $t0, 1  # Tăng i lên 1
    add $a0, $a0, 4   # Di chuyển con trỏ đến phần tử kế tiếp trong mảng

    # Kiểm tra xem đã in hết mảng chưa
    bne $t0, $s0, print_loop

    # In dấu xuống dòng
    li $v0, 11     # syscall 11: in dấu xuống dòng
    li $a0, '\n'   # $a0 = ký tự xuống dòng
    syscall

    # Sắp xếp mảng
    jal sort

    # Kết thúc chương trình
    li $v0, 10     # syscall 10: kết thúc chương trình
    syscall

sort:
for1:
    beq $s0, $zero, end  # Kết thúc nếu chỉ còn một phần tử
    li $t0, 0      # $t0 = 0 (i = 0)

for2:
    beq $t0, $s0, update_i  # Cập nhật i nếu đã lặp qua toàn bộ mảng
    li $t1, 0      # $t1 = 0 (j = 0)
    
for3:
    bge $t1, $s0, update_i_inner  # Cập nhật j nếu đã lặp qua toàn bộ mảng con chưa được sắp xếp
    sll $t2, $t1, 2   # $t2 = 4 * j (Chuyển đổi chỉ số thành byte offset)
    add $t2, $a0, $t2  # $t2 = Địa chỉ của A[j]
    lw $t3, 0($t2)    # $t3 = A[j]
    addi $t4, $t1, 1  # $t4 = j + 1
    sll $t5, $t4, 2   # $t5 = 4 * (j + 1) (Chuyển đổi chỉ số thành byte offset)
    add $t5, $a0, $t5  # $t5 = Địa chỉ của A[j + 1]
    lw $t6, 0($t5)    # $t6 = A[j + 1]

    # So sánh A[j] và A[j + 1], nếu A[j] > A[j + 1], hoán đổi hai giá trị
    ble $t3, $t6, no_swap
    sw $t6, 0($t2)   # A[j] = A[j + 1]
    sw $t3, 0($t5)   # A[j + 1] = A[j]
no_swap:

    addi $t1, $t1, 1  # Tăng j lên 1
    j for3  # Lặp lại vòng lặp for3

update_i_inner:
    addi $t0, $t0, 1  # Tăng i lên 1
    j for2  # Lặp lại vòng lặp for2

update_i:
    addi $s0, $s0, -1  # Giảm n xuống 1
    j for1  # Lặp lại vòng lặp for1

end:
	jr $ra  # Trả về địa chỉ trả về gọi hàm
