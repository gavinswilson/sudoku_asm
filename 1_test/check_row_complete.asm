section .text
    global check_row_complete

section .data
    row_complete_count db 0  ; flag to indicate if the row is complete
    row_length   equ 9  ; length of the row (9 for a standard Sudoku row)
    row_data db 0
    row_data_length equ 81  ; total length of the row data (9x9 Sudoku grid)

check_row_complete:
    ; rdi = pointer to the grid array
    xor rbx, rbx                  ; rbx = loop index
    push rdi
.loop:
    movzx rax, byte [rel lengthArray]
    cmp rbx, rax
    jge .done
    mov rdi, [rsp]
    ; load integer into eax
    mov eax, [rdi + rbx*4]

    ; decide if space or newline
    inc rbx                         ; increment loop index
    
    pop rdi
    jmp .loop    
    
.done:
        
    ret