section .data
    filename    db "test.txt", 0
    buffer      times 4096 db 0
    int_array   times 81 dd 0         ; 81 x 32-bit integers
    space       db ' '
    newline     db 10
    width       db 9
    height      db 9
    lengthArray db 81
    ints        dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

section .bss
    numbuf      resb 12

section .text
    global _start

_start:
    ; print ints

    xor rbx, rbx                  ; rbx = loop index

.loop:
    movzx rax, byte [rel lengthArray]
    cmp rbx, rax
    jge .load_file

    ; load integer into eax
    mov eax, [rel ints + rbx*4]

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
    
.load_file:    
    ; open("input.txt", O_RDONLY)
    mov     rax, 2
    lea     rdi, [rel filename]
    xor     rsi, rsi
    syscall
    mov     r12, rax                  ; r12 = file descriptor

    ; read(fd, buffer, 4096)
    mov     rax, 0
    mov     rdi, r12
    lea     rsi, [rel buffer]
    mov     rdx, 4096
    syscall
    mov     r13, rax                  ; r13 = bytes read

    ; close(fd)
    mov     rax, 3
    mov     rdi, r12
    syscall

    ; parse buffer into integers
    lea     rsi, [rel buffer]         ; current char
    lea     rdi, [rel int_array]      ; where to store parsed integers
    xor     rbx, rbx                  ; current number (as 64-bit)
    xor     rcx, rcx                  ; counter (how many numbers parsed)

.parse_loop:
    mov     al, [rsi]
    cmp     al, 0
    je      .print_loaded

    cmp     al, ','                   ; delimiter
    je      .store_number

    ; skip non-digit
    cmp     al, '0'
    jb      .skip
    cmp     al, '9'
    ja      .skip

    sub     al, '0'
    imul    rbx, rbx, 10
    add     rbx, rax

.skip:
    inc     rsi
    jmp     .parse_loop

.store_number:
    mov     dword [rdi], ebx          ; store as 32-bit value
    add     rdi, 4                    ; move to next dd slot
    inc     rcx
    xor     rbx, rbx                  ; reset current number
    inc     rsi
    jmp     .parse_loop


    ; print loaded array

.print_loaded:
    xor rbx, rbx                  ; rbx = loop index

.loop2:
    movzx rax, byte [rel lengthArray]
    cmp rbx, rax
    jge .done

    ; load integer into eax
    mov eax, [rel int_array + rbx*4]

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
    je .newline2

.space2:
    ; print space
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall
    jmp .loop2

.newline2:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall
    jmp .loop2


.done:
    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall

; ------------------------------------------------
; print_int: converts EAX to ASCII and prints it
; clobbers: rax, rcx, rdx, rsi, rdi
; ------------------------------------------------
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
