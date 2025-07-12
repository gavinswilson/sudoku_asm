section .data
    space       db ' '
    newline     db 10
    width       db 9
    height      db 9
    lengthArray db 81
    welcome_msg db "Welcome to the Sudoku Solver!", 10
    welcome_msg_len equ $ - welcome_msg

section .bss
    numbuf      resb 12

section .text
    global print_grid_array
    global print_int
    global print_welcome

print_welcome:
    ; Print welcome message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel welcome_msg]
    mov rdx, welcome_msg_len
    syscall
    ret

print_grid_array:
    ; rdi = pointer to the grid array
    xor rbx, rbx                  ; rbx = loop index
    push rdi
.loop:
    movzx rax, byte [rel lengthArray]
    cmp rbx, rax
    jge .done_print
    mov rdi, [rsp]
    ; load integer into eax
    mov eax, [rdi + rbx*4]
    
    push rbx
    call print_int
    pop rbx

    ; decide if space or newline
    inc rbx                         ; increment loop index
    mov rax, rbx                    ; rax = new loop index
    xor rdx, rdx              ; clear rdx for division
    movzx rcx, byte [rel width]    ; width of the grid into rcx
    div rcx                        ; rdx remainder of rax/src -> rax % 3
    cmp rdx, 0               ; check if we need a space or newline - if the remainder is 0, we print a newline, othersiwe a space
    je .newline

.space:
    ; print space
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall
    jmp .loop

.newline:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall
    jmp .loop    

.done_print:
    pop rdi
    ret


print_int:
    lea rsi, [numbuf + 11]
    mov byte [rsi], 0
    xor rcx, rcx

.convert:
    xor edx, edx
    mov ebx, 10
    div ebx
    dec rsi
    add dl, '0'
    mov [rsi], dl
    inc rcx
    test eax, eax
    jnz .convert

    ; write the result
    mov rax, 1
    mov rdi, 1
    mov rdx, rcx
    syscall
    
    ret
