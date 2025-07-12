extern exit_gracefully
extern read_puzzle_file
extern print_grid_array
extern print_int
extern print_welcome

section .data
    filename    db "test.txt", 0
    solve_grid  dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


section .text
    global _start

_start:

    call print_welcome

    lea rdi, [rel solve_grid]
    call print_grid_array

    lea rdi, [rel filename]
    lea rsi, [rel solve_grid]
    call read_puzzle_file

    lea rdi, [rel solve_grid]
    call print_grid_array
    jmp .done

.done:

   call exit_gracefully

