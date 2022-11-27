/* Kartu Maksimal 2 */
/* Dynamic Predicates */
:- dynamic(card/2).
:- dynamic(lenCard1/1). % panjang untuk player 1
lenCard1(0).
:- dynamic(lenCard2/1). % panjang untuk player 2
lenCard2(0).

/* Deklarasi Fakta */
cardf(1,'Keluar dari Jail').
cardf(6,'Kartu Sakti'). % Angel Card

/* Deklarasi Rules */
randomNumberForCard(Number, 0) :- randomize, get_seed(X), Number is (X mod 9 + 1).
randomNumberForCard(Number, 1) :- randomize, get_seed(X), Number is (X mod 6 + 1).

chanceCard1(Num) :- Num = 1, write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), 
                    assertz(card(p1, Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)), !.
chanceCard1(Num) :- Num = 2, randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    write('Kamu Mendapatkan Uang sebesar '), 
                    write(Saldo), addBalance(p1, Saldo), nl, !.
chanceCard1(Num) :- Num = 3, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Center'), 
                    moveToLocation(p1, gc), nl, !.
chanceCard1(Num) :- Num = 4, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'),
                    moveToLocation(p1, go), nl, !.
chanceCard1(Num) :- Num = 5, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'),
                    moveToLocation(p1, wt), nl, !.
chanceCard1(Num) :- Num = 6, write('Selamat Kamu Mendapatkan Kartu Sakti'), 
                    assertz(card(p1,Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)), !.
chanceCard1(Num) :- Num = 7, write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'), 
                    moveToClosestTax(p1), nl, !.
chanceCard1(Num) :- Num = 8, write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'), 
                    changeLokasiPemain(p1, jl), nl, !.
chanceCard1(Num) :- Num = 9, write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), 
                    moveToLocation(p1, fp), nl, !.

chanceCard2(Num) :- Num = 1, write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), 
                    assertz(card(p2, Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.
chanceCard2(Num) :- Num = 2, randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50,
                    write('Kamu Mendapatkan Uang sebesar '), 
                    write(Saldo), addBalance(p2, Saldo), nl, !.
chanceCard2(Num) :- Num = 3, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Center'),
                    moveToLocation(p2, gc), nl, !.
chanceCard2(Num) :- Num = 4, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'), 
                    moveToLocation(p2, go), nl, !.
chanceCard2(Num) :- Num = 5, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'),
                    moveToLocation(p2, wt), nl, !.
chanceCard2(Num) :- Num = 6, write('Selamat Kamu Mendapatkan Kartu Sakti'), 
                    assertz(card(p2,Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.
chanceCard2(Num) :- Num = 7, write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'),
                    moveToClosestTax(p2), nl, !.
chanceCard2(Num) :- Num = 8, write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'), 
                    changeLokasiPemain(p2, jl), nl, !.
chanceCard2(Num) :- Num = 9, write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), 
                    moveToLocation(p2, fp), nl, !.

/* Kartu kalau sudah 3 */
isChangeCard1(X, Num) :- X = 3, write('Kartumu berlebih mau mengambil kartu baru?[y/n]'), nl, read(Answer), 
                        ((Answer = y, retract(card(p1,_LastCard)), !) ; (Answer = n, retract(card(p1, Num)), !) ; 
                        (Answer \= y, Answer \= n, write('Input tidak valid'), nl, isChangeCard1(X, Num), !)),
                        retract(lenCard1(Len)), LenNew is Len - 1, asserta(lenCard1(LenNew)), !.
isChangeCard2(X, Num) :- X = 3, write('Kartumu berlebih mau mengambil kartu baru?[y/n]'), nl, read(Answer), 
                        ((Answer = y, retract(card(p2,_LastCard)), !) ; (Answer = n, retract(card(p2, Num)), !) ; 
                        (Answer \= y, Answer \= n, write('Input tidak valid'), nl, isChangeCard2(X, Num), !)), 
                        retract(lenCard2(Len)), LenNew is Len - 1, asserta(lenCard2(LenNew)), !.

isPoor(Player) :- balance(Player, Balance1), ((Player = p1, X is 1, !); (Player = p2, X is 2,!)),Y is (X + 2), NumPlayerLain is (Y mod 2 + 1),
                          ((NumPlayerLain == 1, OtherPlayer = p1) ;(NumPlayerLain == 2, OtherPlayer = p2)),
                           balance(OtherPlayer, Balance2), (Balance1 < (Balance2 * 0.5)), !.

/* taro di main langsung aja | untuk kocok kartu */
runCard:-  currentPemain(_P), lokasiPemain(_P, Tempat),
            (
            Tempat \== cc1, Tempat \== cc2, Tempat \== cc3,
            write('Kamu tidak berada di chance card...'), write(Tempat), nl
            ;
                (Tempat == cc1 ; Tempat == cc2 ; Tempat == cc3),
                (
                    isPoor(_P),
                    randomNumberForCard(Number, 1), 
                    (
                        (
                            _P == p1, chanceCard1(Number), 
                            lenCard1(X), 
                            (
                                isChangeCard1(X, Number), !
                                ;
                                \+ isChangeCard1(X, Number), !
                            )
                            
                        ) , ! 
                        ; 
                        (
                            _P == p2, 
                            chanceCard2(Number), 
                            lenCard2(X), 
                            (
                                isChangeCard2(X, Number),!
                                ;
                                \+ isChangeCard2(X, Number), !
                            )
                        ), !
                    ), !
                    ;
                    \+ isPoor(_P),
                    randomNumberForCard(Number, 0), 
                    ((_P == p1, chanceCard1(Number), lenCard1(X), isChangeCard1(X, Number), !) ; (_P == p2, chanceCard2(Number), lenCard2(X), isChangeCard2(X, Number),!), !), !
                ),!
            ), !. 

/* program untuk print card */
infoCard :- currentPemain(_P), _P = p1, lenCard1(_Len), _Len = 0, write('Kamu tidak memiliki kartu'), nl, !.        
infoCard :- currentPemain(_P), _P = p1, lenCard1(_Len), _Len \= 0,  write('Kartu Kamu : '), nl, nl,
            (currentPemain(_P), card(_P,Temp), cardf(Temp, _Num), write(_Num), nl, fail ), !.
infoCard :- currentPemain(_P), _P = p2, lenCard2(_Len), _Len = 0, write('Kamu tidak memiliki kartu'), nl, !.        
infoCard :- currentPemain(_P), _P = p2, lenCard2(_Len), _Len \= 0,  write('Kartu Kamu : '), nl, nl,
            (currentPemain(_P), card(_P,Temp), cardf(Temp, _Num), write(_Num), nl, fail ), !.