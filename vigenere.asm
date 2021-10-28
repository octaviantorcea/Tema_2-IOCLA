%include "io.mac"

letter_A        equ 65
letter_Z        equ 90
letter_a        equ 97
letter_z        equ 122
alphabet_length equ 26

section .data
    len_text    dd  0
    len_key     dd  0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov     dword [len_text], ecx
    mov     dword [len_key], ebx

    ;; converting from characters to just numbers
modify_key:
    sub     byte [edi + ebx - 1], letter_A
    dec     ebx
    jnz     modify_key

    xor     ecx, ecx            ; using it as index for text
    xor     ebx, ebx            ; using it as index for key

    ;; while ecx < len_text
while_len_text:
    ;; se verifica daca este nevoie sa se reseteze indexul din key
    cmp     ebx, [len_key]
    je      reset_key

back_from_reset:
    cmp     byte [esi + ecx], letter_A
    jb      not_a_letter

    cmp     byte [esi + ecx], letter_Z
    jb      is_uppercase

    cmp     byte [esi + ecx], letter_a
    jb      not_a_letter

    cmp     byte [esi + ecx], letter_z
    jb      is_lowercase

    jmp     not_a_letter

is_lowercase:
    mov     al, [esi + ecx]
    sub     al, alphabet_length
    add     al, [edi + ebx]
    inc     ebx

    cmp     al, letter_a
    jb      need_to_rotate_l

    jmp     add_letter

need_to_rotate_l:
    add     al, alphabet_length
    jmp     add_letter

is_uppercase:
    mov     al, [esi + ecx]
    add     al, [edi + ebx]
    inc     ebx

    cmp     al, letter_Z
    ja      need_to_rotate_u

add_letter:
    mov     byte [edx + ecx], al
    inc     ecx

    cmp     ecx, [len_text]
    jb      while_len_text

    jmp     done

need_to_rotate_u:
    sub     al, alphabet_length
    jmp     add_letter

not_a_letter:
    mov     al, [esi + ecx]
    jmp     add_letter

reset_key:
    sub     ebx, [len_key]
    jmp     back_from_reset

done:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
