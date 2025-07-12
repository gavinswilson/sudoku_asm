section .data
    msg db "Hello ", 0xA
    msg_len equ $ - msg
    msg2 db "what's your name?", 0xA
    msg2_len equ $ - msg2
    
section .bss    
    name resb 128
    name_len resq 1

section .text
    global _start

_start:
    mov rsi, msg2    ; pointer to message
    mov rdx, msg2_len; message length
    call _screen_write ; write the message to stdout
    
    lea rsi, [name] ; pointer to message
    mov rdx, 128    ; message length
    call _screen_read ; read input from stdin
    
    mov [name_len], rax ; store the length of the name

    mov rsi, msg    ; pointer to message
    mov rdx, msg_len; message length
    call _screen_write ; write the message to stdout

    mov rsi, name    ; pointer to message
    mov rdx, name_len; message length
    call _screen_write ; write the name to stdout

    mov rax, 60     ; syscall: exit
    mov rdi, 0      ; exit code: 0
    syscall         ; call kernel



_screen_write:
    mov rax, 1      ; syscall: write
    mov rdi, 1      ; file descriptor: stdout
    syscall         ; call kernel
    ret

_screen_read:
    mov rax, 0      ; syscall: read
    mov rdi, 0      ; file descriptor: stdin
    syscall         ; call kernel
    ret