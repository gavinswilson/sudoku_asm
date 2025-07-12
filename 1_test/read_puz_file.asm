section .data
    buffer      times 4096 db 0

section .text
    global read_puzzle_file

read_puzzle_file:    
    ; open("input.txt", O_RDONLY)
    push rsi
       
    mov     rax, 2
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
    pop rdi
    
    xor     rbx, rbx                  ; current number (as 64-bit)
    xor     rcx, rcx                  ; counter (how many numbers parsed)

.parse_loop:
    mov     al, [rsi]
    cmp     al, 0
    je      .done3

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

.done3:
    ; store last number if we haven't stored it yet
    cmp rcx, 81
    jae .ret              ; don't overrun
    mov dword [rsi], ebx  ; store final parsed number
.ret:
    ret