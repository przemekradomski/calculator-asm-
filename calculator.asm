section .bss
    buf1 resb 16
    buf2 resb 16

section .text
    global _start

_start:

    ; --- Wczytaj pierwszą liczbę ---
    mov rax, 0
    mov rdi, 0
    mov rsi, buf1
    mov rdx, 16
    syscall

    mov rsi, buf1
    call atoi
    mov r12, rax

    ; --- Wczytaj drugą liczbę ---
    mov rax, 0
    mov rdi, 0
    mov rsi, buf2
    mov rdx, 16
    syscall

    mov rsi, buf2
    call atoi

    ; --- dodawanie ---
    add rax, r12

    ; --- konwersja ---
    mov rdi, buf1
    call itoa

    ; --- wypisanie ---
    mov rax, 1
    mov rdi, 1
    mov rsi, rbx    
    mov rdx, 16
    syscall

    ; --- exit ---
    mov rax, 60
    xor rdi, rdi
    syscall


; ==========================
; atoi
atoi:
    xor rax, rax
    xor rcx, rcx

.convert:
    mov cl, [rsi]
    cmp cl, 10
    je .done
    cmp cl, 0
    je .done
    sub cl, '0'
    imul rax, rax, 10
    add rax, rcx
    inc rsi
    jmp .convert

.done:
    ret


; ==========================
; itoa
itoa:
    mov rcx, 10
    mov rbx, rdi
    add rbx, 15
    mov byte [rbx], 10
    dec rbx

.convert2:
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rbx], dl
    dec rbx
    test rax, rax
    jnz .convert2

    inc rbx
    ret