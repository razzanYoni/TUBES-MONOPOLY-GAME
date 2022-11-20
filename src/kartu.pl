/* Kartu Maksimal 3 */
:- [dadu].
/* Dynamic Predicates */
:- dynamic(card1/1). % untuk player 1
:- dynamic(lenCard1/1). % panjang untuk player 2
:- dynamic(card2/1). % untuk player 2
:- dynamic(lenCard2/1). % panjang untuk player 2
:- dynamic(currentNumber/1). % 

/* Deklarasi Fakta */
% cardList([1,2,3,4,5,6,7,8,9]).
card(1,'Keluar dari Jail').
card(2,'Mendapatkan Uang').
card(3,'Pergi Ke Permainan Koin').
card(4,'Pergi Ke Start').
card(5,'Pergi Keliling Dunia').
card(6,'Kartu Sakti'). % Angel Card
card(7, 'Pergi Ke Tax Terdekat').
card(8, 'Pergi Ke Jail').
card(9, 'Pergi Ke Parkir').

/* Deklarasi Rules */
carding :- throwDice.
angkaKartu :- random(1, 9, Angka), asserta(currentNumber(Angka)).

/* keluar dari jail kartu */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 1, retract(currentNumber(Num)), write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), assertz(card1(Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)), !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 1, retract(currentNumber(Num)), write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), assertz(card2(Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.

/* hadiah balance */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 2, retract(currentNumber(Num)), random(1, 5, Pengali), Saldo is Pengali * 50, write('Kamu Mendapatkan Uang sebesar '), write(Saldo), /* Proses memasukkan saldo ke Pemain 1*/ nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 2, retract(currentNumber(Num)), random(1, 5, Pengali), Saldo is Pengali * 50, write('Kamu Mendapatkan Uang sebesar '), write(Saldo), /* Proses memasukkan saldo ke Pemain 2*/ nl, !.

/* pergi ke permainan koin */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 3, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Koin'), /* Proses memajukan pemain hingga ke koin untuk Pemain 1*/ nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 3, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Koin'), /* Proses memajukan pemain hingga ke koin untuk Pemain 2*/ nl, !.

/* pergi ke start kartu */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 4, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'), /* Proses memajukan pemain hingga ke start untuk Pemain 1 */ nl, !.
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 4, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'), /* Proses memajukan pemain hingga ke start untuk Pemain 2 */ nl, !.

/* pergi keliling dunia */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 5, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'), /* Proses memajukan pemain hingga ke keliling dunia untuk Pemain 1 Ingat untuk mengubah giliran pemain*/  nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 5, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'), /* Proses memajukan pemain hingga ke keliling dunia untuk Pemain 2 Ingat untuk mengubah giliran pemain*/  nl, !.

/* Angel Card */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 6, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kartu Sakti'), assertz(card1(Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)), !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 6, retract(currentNumber(Num)), write('Selamat Kamu Mendapatkan Kartu Sakti'), assertz(card1(Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.

/* tax terdekat */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 7, retract(currentNumber(Num)), write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'), /* Proses memajukan pemain hingga ke tax terdekat untuk Pemain 1 */ nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 7, retract(currentNumber(Num)), write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'), /* Proses memajukan pemain hingga ke tax terdekat untuk Pemain 2 */ nl, !.

/* pergi ke jail kartu*/
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 8, retract(currentNumber(Num)), write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'), /* Proses memajukan pemain hingga ke jail untuk Pemain 1 */ nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 8, retract(currentNumber(Num)), write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'), /* Proses memajukan pemain hingga ke jail untuk Pemain 2 */ nl, !.

/* pergi ke parkir gratis kartu */
chanceCard :- /*Pemain 1 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 9, retract(currentNumber(Num)), write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), /* Proses memajukan pemain hingga ke Parkir untuk Pemain 1 */ nl, !.
chanceCard :- /*Pemain 2 */ retract(currentNumber(Num)), asserta(currentNumber(Num)), Num = 9, retract(currentNumber(Num)), write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), /* Proses memajukan pemain hingga ke Parkir untuk Pemain 2 */ nl, !.

/* program untuk kocok kartu */
runCard1 :- angkaKartu, tanyaCard1(X), ((X = 0, chanceCard) ; (X = 2)), !.
runCard1 :- chanceCard, !.
runCard2 :- angkaKartu, chanceCard.
tanyaCard1(X) :- retract(lenCard1(A)), asserta(lenCard1(A)), \+ A >= 2, X is 1, !.
tanyaCard1(X) :- retract(currentNumber(Num)), asserta(currentNumber(Num)), \+ ((Num = 1) ; (Num = 6)), X is 1, !.
tanyaCard1(H) :- retract(lenCard1(A)), asserta(lenCard1(A)), A >= 2, retract(currentNumber(Num)), asserta(currentNumber(Num)), ((Num = 1) ; (Num = 6)), card(Num, _X), printCardP1, nl, write('Kamu Mendapatkan Kartu : '), write(_X), nl, write('Apakah Ingin Mengganti Dengan Kartu Pertamamu? (y/n) \n'), read(Y), ((Y = y , H is 0) ; (Y = n, H is 2, !)), ((H = 0, retract(lenCard1(A)), A1 is A - 1, asserta(lenCard1(A1)), retract(card1(HHH)), nl, nl) ; (H = 2)), !. 

/* program untuk print kartu P1 */
printCardP1 :- retract(lenCard1(Len)), asserta(lenCard1(Len)), stateCard(0, Len), nl, !.
stateCard(0, 0) :- write('Kamu Tidak Memiliki Kartu'), nl, !.
stateCard(Y, Y) :- \+ Y = 0.
stateCard(X, Y) :- X < Y, retract(card1(A)), assertz(card1(A)), X1 is X + 1, write(X1), write('. '), write('Kamu Memiliki Kartu '), card(A, _X), write(_X), nl, stateCard(X1, Y).

/* Run di main */
kartu :- asserta(lenCard1(0)), asserta(lenCard2(0)), asserta(dice(11)).

