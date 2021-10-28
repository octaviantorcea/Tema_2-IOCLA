%include "io.mac"

alphabet_length equ 26
letter_A        equ 65
letter_Z        equ 90
letter_a        equ 97
letter_z        equ 122

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

cipher_caesar:
    mov     bh, byte [esi + ecx - 1]

    cmp     bh, letter_A
    jb      add_letter

    cmp     bh, letter_Z
    jb      is_uppercase

    cmp     bh, letter_a
    jb      add_letter

    cmp     bh, letter_z
    jb      is_lowercase

    jmp     add_letter

is_uppercase:
    mov     bl, alphabet_length
    mov     eax, edi
    div     bl                  ; trebuie adaugat doar restul impartirii
    add     bh, ah

    cmp     bh, letter_Z
    jg      need_to_rotate_u

    jmp     add_letter

    ;; in caz ca este uppercase, dar in urma adunarii
    ;; cu key iese din range-ul literelor
need_to_rotate_u:
    sub     bh, alphabet_length
    jmp     add_letter

is_lowercase:
    mov     bl, alphabet_length
    mov     eax, edi
    div     bl
    sub     bh, alphabet_length ; e posibil ca suma sa fie peste 127
    add     bh, ah

    cmp     bh, letter_a
    jb      need_to_rotate_l

    jmp     add_letter

    ;; in caz ca in este lowercase, dar in urma operatiilor iese din
    ;; din range-ul literelor 
need_to_rotate_l:
    add     bh, alphabet_length
    jmp     add_letter

add_letter:
    mov     [edx + ecx - 1], bh
    loop    cipher_caesar

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
