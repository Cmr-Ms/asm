bits 64
default rel

%define STACK_SIZE 8+32+16

section .data
    msg db "assembly"
    msg_len equ $ - msg

section .bss
    written resq 1

section .text
    extern GetStdHandle
    extern WriteFile
    extern ExitProcess

global main

main:
    sub rsp, STACK_SIZE

    mov rax, [msg]
    mov [rsp+40], rax
    mov ecx, -11
    call GetStdHandle
    mov r13, rax
    jmp .loop
    
.loop:
    
    mov rcx, r13

    lea rdx, [rsp+40]
    mov r8d, msg_len
    lea r9, [written]
    mov [rsp+32], 0
    call WriteFile

    inc qword [rsp+40]

    jmp .loop

    add rsp, STACK_SIZE
    xor ecx, ecx
    call ExitProcess
