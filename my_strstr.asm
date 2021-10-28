%include "io.mac"

section .data
    haystack_len    dw 0
    needle_len      dw 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    mov     word [haystack_len], cx
    mov     word [needle_len], dx

    xor     ecx, ecx    ; using it as index for haystack
    xor     edx, edx    ; using it as index for needle

    ;; cat timp ecx < haystack_len
while_ecx:
    mov     al, [ebx + edx]
    push    ecx

    cmp     byte [esi + ecx], al    ; daca sunt egale
    je      verify

    pop     ecx
    inc     ecx

    cmp     cx, [haystack_len]
    jb      while_ecx

    jmp     not_found

    ;; se verifica daca secventa din string este identica cu needle
verify:
    inc     ecx
    inc     edx

    ;; daca edx == needle_len inseamna ca s-a gasit secvent in string
    cmp     dx, [needle_len]
    je      found_it

    mov     al, [ebx + edx]

    cmp     byte [esi + ecx], al
    je      verify

    pop     ecx
    inc     ecx
    xor     edx, edx

    cmp     ecx, [haystack_len]
    je      not_found

    jmp     while_ecx

found_it:
    pop     ecx
    mov     byte [edi], cl
    jmp     done

    ;; daca nu a fost gasit, in edi se pune lungimea stringului + 1
not_found:
    mov     al,  byte [haystack_len]
    mov     dword [edi], eax
    inc     dword [edi]

done:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
