/* Deklarasi Fakta */

/* Deklarasi Rules */
% dynamic predikat double/1 untuk menyimpan berapa kali dadu yang double
:- dynamic(double/1).

% dynamic predikat dice/1 untuk menyimpan nilai dadu, hanya berisikan angka dadu pertama dan kedua
:- dynamic(dice/1).

% rules randomNumberForDice untuk meng-generate angka random 1-6
randomNumberForDice(Number) :- random(1, 7, Number).

% dynamic predikat jailFromDice/1 untuk menyimpan 
% pemain yang berada dalam jail sebanyak turn yang perlu ditempuh 
% e.g pemain 1 dalam jail maka berisikan 
% jail(X)
% X = 1
% X = 1
% karena pemain 1 harus menempuh 2 turn dalam jail dan turn ke 3 dia keluar
% kondisi keluar jail : kartu, dadu double, bayar, turn 3x

:- dynamic(jail/1).

/* rules throwDice untuk melempar 2 dadu lalu ditampilkan hasilnya dan menyimpan nilai dadu kedalam dynamic predikat dice/1 */
% lemparan pertama
throwDice :- % berisikan dynamic giliranpemain/1
             _Pemain is 1,
             \+ jail(_Pemain), \+ double(X), asserta(double(0)),
             randomNumberForDice(Number1), randomNumberForDice(Number2), 

             % output pemain 

             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 
             Total is Number1 + Number2,
             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, 
             ((Number1 = Number2, retractall(double(X)), asserta(double(1))) % kondisi ketika player mendapat double maka dia lanjut lempar dadu, jangan lupa beri prosedur (harusnya gausah karena kan dia tetap) lanjutnya harusnya ada di main
             ; 
             (Number1 \= Number2, retractall(double(X)))), % kondisi ketika player tidak mendapat double maka dia berhenti lempar dadu, jangan lupa beri prosedur berhentinya harusnya ada di main
             !.

% lemparan selanjutnya, kondisi ketika belum double sebanyak 3 kali
throwDice :- % berisikan dynamic giliranpemain/1
             _Pemain is 1,
             \+ jail(_Pemain),
             randomNumberForDice(Number1), randomNumberForDice(Number2), 
             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 

             ((Number1 = Number2, retract(double(X)), X1 is X + 1, asserta(double(X1)), X1 \= 3) % kondisi ketika player mendapat double maka dia lanjut lempar dadu, jangan lupa beri prosedur (harusnya gausah karena kan dia tetap) lanjutnya harusnya ada di main
             ; 
             (Number1 \= Number2, retractall(double(X)))), % kondisi ketika player tidak mendapat double maka dia berhenti lempar dadu, jangan lupa beri prosedur berhentinya harusnya ada di main
             Total is Number1 + Number2,
             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, !.

% lemparan selanjutnya, kondisi ketika sudah double sebanyak 3 kali
throwDice :- _Pemain is 1,
             \+ jail(_Pemain),
             % kondisi masuk penjara, pemain masuk penjara dan giliran pemain berikutnya (jangan lupa prosedurnya)

             write('Anda masuk ke jail karena mendapatkan Double 3 kali berturut-turut'), nl, 
             retractall(double(X)), asserta(jail(_Pemain)), asserta(jail(_Pemain)),!.
             % janganlupa ganti masukan pemain yang ke jail

/* keluar dari jail dengan dadu*/
% jika dadu double maka pemain keluar dari jail
throwDice :- _Pemain is 1,
             randomNumberForDice(Number1), randomNumberForDice(Number2), 
             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 
             Number1 = Number2, retractall(jail(_Pemain)),
             Total is Number1 + Number2,
             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, !.

% jika dadu bukan double
throwDice :- _Pemain is 1,
             write('Anda masih dalam jail'), nl,
             retract(jail(_Pemain)), !.

