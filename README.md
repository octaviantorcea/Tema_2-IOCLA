## `otp.asm`

Se iau pe rand, in ordine inversa, octetii din plaintext si key, se face
xor intre ei, apoi rezultatul se pune in ciphertext.


## `caesar.asm`

Se compara fiecare octet (in ordine inversa) din plaintext pentru a se
vedea in ce categorie de caracter este (uppecase letter, lowercase letter sau
special character). In caz ca nu este litera se copiaza in ciphertext. Daca
este uppercase, se adauga doar restul impartirii lui key la 26 (nr. de litere
din alfabet) si se verifica daca in urma adunarii a iesit din range-ul
literelor mari, caz in care se va scadea 26. Daca este lowercase, mai intai se
scade 26, deoarece este posibil ca in urma adunarii rezultatul sa fie peste 127
(rezultatul se retine in registrul AL, deci doar un octet). Apoi se aduna cu
restul impartirii lui key la 26, apoi se verifica daca este necesar sa se adune
inapoi 26.


## `vigenere.asm`
La inceput, in stringul key, se scade din fiecare octet 65 (codul ASCII
pentru A), astfel incat sa reprezinte numarul cu care trebuie deplasate
literele din plaintext. Apoi este practic aceleasi algoritm ca la caesar.asm.


## `my_strstr.asm`

Folosesc varibilele haystack_len si needle_len pentru a stoca lungimea
sirului si a secventei ce trebuie gasita (astfel ma pot folosi de registerle
ecx si edx). Se cauta in haystack primul caracter care este identic cu primul
din needle, apoi se verifica si toate celelalte needle_len - 1 caractere dupa
acesta sa fie aceleasi cu cele din needle. Daca s-a gasit o secventa de tipul
acesta, se iese din loop si se pune in adresa de la edi indexul de inceput al
secventei. In caz contrar se continua cautarea pana cand ecx == haystack_len.


## `bin_to_hex.asm`

La  inceput se convertesc octetii din bin_sequence din caracterele '0' si
'1' la numerele 0 si 1. Se imparte length la 4 pentru a vedea cat de lunga este
lungimea secventei in hexazecimal (se retine catul in hex_index si restul in
lonely_bits; in cazul in care restul e diferit de 0, se aduna la hex_index 1).
Se calculeaza apoi pentru fiecare secventa de 4 octeti din bin_sequence (care
practic sunt biti) suma lor in baza 10, apoi se converteste la baza 16.
