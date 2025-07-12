section .text
    global exit_gracefully
    global exit_error

exit_gracefully:
    mov rax, 60
    mov rdi, 0
    syscall

exit_error:
    mov rax, 60
    mov rdi, 1
    syscall
    ret