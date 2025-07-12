section .data
    ints    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    space   db ' '
    newline db 10
    width  db 9
    height db 9
    lengthArray db 81

section .bss
    numbuf  resb 12

section .text
global _start

_start: ; initialize the loop
    xor rbx, rbx                  ; rbx = loop index

.loop:
    movzx rax, byte [rel lengthArray]
    cmp rbx, rax
    jge .done

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
