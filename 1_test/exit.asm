section .text
    global exit_gracefully

exit_gracefully:
    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall