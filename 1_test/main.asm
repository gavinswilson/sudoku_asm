extern exit_gracefully
extern read_puzzle_file
extern print_grid_array
extern print_int

section .data
    filename    db "test.txt", 0
    ; int_array   times 81 dd 0         ; 81 x 32-bit integers
    ints        dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


section .text
    global _start

_start:
    lea rdi, [rel ints]
    call print_grid_array

    lea rdi, [rel filename]
    ; lea rsi, [rel int_array]
    lea rsi, [rel ints]
    call read_puzzle_file

    ; lea rdi, [rel int_array]
    lea rdi, [rel ints]
    call print_grid_array

.done:
   call exit_gracefully

