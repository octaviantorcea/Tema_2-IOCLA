%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

cipher_otp:
    mov     al, byte [esi + ecx - 1]
    mov     bl, byte [edi + ecx - 1]
    xor     al, bl
    mov     [edx + ecx - 1], al
    loop    cipher_otp

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
