/*DEPENDENCY KE player.pl*/

/* Deklarasi Fakta */

/* Deklarasi Rules */
/* dynamic predikat double/1 untuk menyimpan berapa kali dadu yang double */
:- dynamic(double/1).

/* rules randomNumberForDice untuk meng-generate angka random 1-6 */
randomNumberForDice(Number) :- randomize, get_seed(X), Number is (6).

/* pemain yang berada dalam jail sebanyak turn yang perlu ditempuh  */
:- dynamic(jail/1).

/* rules throwDice untuk melempar 2 dadu lalu ditampilkan hasilnya dan menyimpan nilai dadu kedalam dynamic predikat dice/1 */
/* lemparan pertama */
throwDice :-
             currentPemain(_Pemain),
             \+ jail(_Pemain), \+ double(X), asserta(double(0)),
             randomNumberForDice(Number1), randomNumberForDice(Number2), 
             nl, write(_Pemain), nl, 
             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 
             Total is Number1 + Number2,
             move(_Pemain, Total),
             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, 
             ((Number1 == Number2, retractall(double(X)), asserta(double(1))) 
             ; 
             (Number1 =\= Number2, retractall(double(X)))),
             !.

/* lemparan selanjutnya, kondisi ketika belum double sebanyak 3 kali */
throwDice :- currentPemain(_Pemain),
             \+ jail(_Pemain),
             randomNumberForDice(Number1), randomNumberForDice(Number2), 
             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 
             ((Number1 == Number2, retract(double(X)), X1 is X + 1, asserta(double(X1)), X1 =\= 3) 
             ; 
             (Number1 =\= Number2, retractall(double(X)))),
             Total is Number1 + Number2,

             move(_Pemain, Total),

             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, !.

/* lemparan selanjutnya, kondisi ketika sudah double sebanyak 3 kali */
throwDice :- currentPemain(_Pemain),
             \+ jail(_Pemain),
             changeLokasiPemain(_Pemain, jl),
             write('Anda masuk ke jail karena mendapatkan Double 3 kali berturut-turut'), nl, 
             retractall(double(_X)), asserta(jail(_Pemain)), asserta(jail(_Pemain)),!.

/* keluar dari jail dengan dadu*/
/* jika dadu double maka pemain keluar dari jail */
throwDice :- currentPemain(_Pemain),
             randomNumberForDice(Number1), randomNumberForDice(Number2), 
             write('Dadu 1: '), write(Number1), nl, 
             write('Dadu 2: '), write(Number2), nl, 
             Number1 = Number2, retractall(jail(_Pemain)),
             Total is Number1 + Number2,
             move(_Pemain, Total),
             write('Anda maju sebanyak '), write(Total), write(' langkah'), nl, !.

/* jika dadu bukan double */
throwDice :- currentPemain(_Pemain),
             write('Anda masih dalam jail'), nl,
             retract(jail(_Pemain)), !.