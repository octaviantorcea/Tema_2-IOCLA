%include "io.mac"

one_hex_length  equ 4
symbol_zero     equ 48
hex             equ 16

section .data
    hex_index   db  0           ; cat de lunga e secventa in hexa
    lonely_bits db  0           ; cati biti raman fara sa fie completata o secventa
    rem         db  0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    push    ecx

    ;; converting from characters to numbers
modify_bin:
    sub     byte [esi + ecx - 1], symbol_zero
    loop    modify_bin

    pop     ecx

    ;; calculeaza cat de lunga este secventa in hexa
    mov     eax, ecx
    xor     ebx, ebx
    mov     bl, one_hex_length
    div     bl
    mov     byte [hex_index], al
    mov     byte [lonely_bits], ah

    ;; in caz ca restul este 0 nu este nevoie sa fie incrementat cu 1
    cmp     byte [lonely_bits], 0
    jne     ingore

    dec     byte [hex_index]

ingore:
    xor     eax, eax
    mov     al, byte [hex_index]
    push    eax

while_hex_index:
    mov     ebx, 1                      ; stores current power
    mov     eax, 0                      ; stores the sum
    mov     byte [rem], one_hex_length  ; un caracte in hexa <=> 4 caractere in binar

    ;; pentru fiecare secventa de 4 biti se calculeaza suma lor
while_rem:
    cmp     byte [esi + ecx - 1], 1
    je      adding

back:
    shl     ebx, 1
    dec     ecx
    dec     byte [rem]
    jnz     while_rem
    jmp     put_in_edx

adding:
    add     eax, ebx
    jmp     back

put_in_edx:
    mov     bl, byte [hex_index]
    mov     [edx + ebx], al
    dec     byte [hex_index]
    jnz     while_hex_index

    mov     ebx, 1                  ; stores current power
    mov     eax, 0                  ; stores the sum

    ;; Aici probabil se poate evita cumva codul duplicat insa eram prea fericit
    ;; ca am terminat tema si nu am mai optimizat. E practic aceeasi secventa
    ;; de mai sus cu foarte mici schimbari.

    ;; pentru bitii care nu completeaza o secventa intreaga
while_lonely_bits:
    cmp     byte [esi + ecx - 1], 1
    je      adding2

back2:
    shl     ebx, 1
    dec     ecx
    dec     byte [lonely_bits]
    jnz     while_lonely_bits
    jmp     put_in_edx2

adding2:
    add     eax, ebx
    jmp     back2

put_in_edx2:
    mov     bl, byte [hex_index]
    mov     [edx + ebx], al

    ;; transforma din numere in caractere ASCII
translating_to_hex:
    pop     ebx
    inc     ebx
    add     byte [edx + ebx], 10    ; ca sa pun '\n' la final
    dec     ebx

while_ecx:
    cmp     byte [edx + ebx], 10    ; if it's number or letter
    jb      is_number

    jmp     is_letter

again:
    dec     ebx

    cmp     ebx, 0
    jnl     while_ecx

    jmp     done

is_number:
    add     byte [edx + ebx], symbol_zero
    jmp     again

is_letter:
    add     byte [edx + ebx], 55
    jmp     again

done:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
