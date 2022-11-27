/* Kartu Maksimal 2 */
/* Dynamic Predicates */
:- dynamic(card/2).
:- dynamic(lenCard1/1). 
lenCard1(0).
:- dynamic(lenCard2/1). 
lenCard2(0).

/* Deklarasi Fakta */
cardf(1,'Keluar dari Jail').
cardf(6,'Kartu Sakti'). % Angel Card

/* Deklarasi Rules */
randomNumberForCard(Number, 0) :- randomize, get_seed(X), Number is (X mod 14 + 1).
randomNumberForCard(Number, 1) :- randomize, get_seed(X), Number is (X mod 7 + 1).

chanceCard1(Num) :- Num = 1, write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), 
                    assertz(card(p1, Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)).
chanceCard1(Num) :- Num = 2, randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    write('Kamu Mendapatkan Uang sebesar '), 
                    write(Saldo), addBalance(p1, Saldo), nl.
chanceCard1(Num) :- Num = 3, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Center'), 
                    moveToLocation(p1, gc), landingGC(p1), nl, !.
chanceCard1(Num) :- Num == 4, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'),
                    moveToLocation(p1, go), landingGO(p1), nl, !.
chanceCard1(Num) :- Num == 5, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'),
                    moveToLocation(p1, wt), landingWT(p1), nl, !.
chanceCard1(Num) :- Num == 6, write('Selamat Kamu Mendapatkan Kartu Sakti'), 
                    assertz(card(p1,Num)), nl, retract(lenCard1(X)), X1 is X + 1, asserta(lenCard1(X1)), !.
chanceCard1(Num) :- Num == 7, write('Selamat Kamu Pergi ke World Cup'), 
                    moveToLocation(p1, wc), landingWC(p1), nl, !.
chanceCard1(Num) :- Num == 8, write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'), 
                    moveToClosestTax(p1), landingTX(p1), nl, !.
chanceCard1(Num) :- Num == 9, write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'), 
                    asserta(jail(p1)), asserta(jail(p1)),
                    changeLokasiPemain(p1, jl), switchPlayer, retractall(double(_X)), nl, 
                    printMap,
                    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
                    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,!.
chanceCard1(Num) :- Num == 10, write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), 
                    moveToLocation(p1, fp), nl, !.
chanceCard1(Num) :- Num == 11, write('Kamu dipalak preman, Silakan Bayar'),
                    randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    subtBalance(p1, Saldo), nl, !.
chanceCard1(Num) :- Num == 12, write('Lawanmu Sedang Mengadakan Pesta, Beri Hadiah Kepada Lawanmu'),
                    randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    subtBalance(p1, Saldo), addBalance(p2, Saldo), nl, !.
chanceCard1(Num) :- Num == 13, write('Propertimu telah usang, Propertimu akan disita'), nl,
                    asetProperti(p1, Properti), \+ landmark(Properti), removePosession(p1, Properti), !.
chanceCard1(Num) :- Num == 13, write('Setelah Dilihat-lihat Ternyata Sudah Aman'), nl, !.
chanceCard1(Num) :- Num == 14, write('Ada Tetanggamu yang Membutuhkan Tempat!!!'), nl,
                    asetProperti(p1, Properti), \+ landmark(Properti), nilaiProperti(Properti, Nilai),
                    NilaiAkhir is (Nilai * 0.8), addBalance(p1, NilaiAkhir), !.
chanceCard1(Num) :- Num == 14, write('Ternyata Nanya Doang Beli Kagak'), nl, !.


chanceCard2(Num) :- Num == 1, write('Kamu Mendapatkan Kartu Untuk Keluar dari Jail'), 
                    assertz(card(p2, Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.
chanceCard2(Num) :- Num == 2, randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50,
                    write('Kamu Mendapatkan Uang sebesar '), 
                    write(Saldo), addBalance(p2, Saldo), nl, !.
chanceCard2(Num) :- Num == 3, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Game Center'),
                    moveToLocation(p2, gc),landingGC(p2), nl, !.
chanceCard2(Num) :- Num == 4, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Ke Start'), 
                    moveToLocation(p2, go),landingGO(p2), nl, !.
chanceCard2(Num) :- Num == 5, write('Selamat Kamu Mendapatkan Kesempatan Untuk Pergi Keliling Dunia'),
                    moveToLocation(p2, wt),landingWT(p2), nl, !.
chanceCard2(Num) :- Num == 6, write('Selamat Kamu Mendapatkan Kartu Sakti'), 
                    assertz(card(p2,Num)), nl, retract(lenCard2(X)), X1 is X + 1, asserta(lenCard2(X1)), !.
chanceCard2(Num) :- Num == 7, write('Selamat Kamu Pergi ke World Cup'), 
                    moveToLocation(p2, wc),landingWC(p2), nl, !.
chanceCard2(Num) :- Num == 8, write('Orang Pintar Bayar Pajak, Silakan Pergi ke Tax Terdekat'),
                    moveToClosestTax(p2),landingTX(p2), nl, !.
chanceCard2(Num) :- Num == 9, write('Kamu Mencurigakan, Silakan Pergi ke Jail Untuk Diperiksa'),
                    asserta(jail(p2)), asserta(jail(p2)),
                    changeLokasiPemain(p2, jl), switchPlayer, retractall(double(_X)), nl,
                    printMap,
                    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
                    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,!.
chanceCard2(Num) :- Num == 10, write('Kamu Terlihat Kelelahan, Silakan Parkir terlebih dahulu'), 
                    moveToLocation(p2, fp), nl, !.
chanceCard2(Num) :- Num == 11, write('Kamu dipalak preman, Silakan Bayar'),
                    randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    subtBalance(p2, Saldo), nl, !.
chanceCard2(Num) :- Num == 12, write('Lawanmu Sedang Mengadakan Pesta, Beri Hadiah Kepada Lawanmu'),
                    randomize, get_seed(X), Pengali is (X mod 5 + 1), Saldo is Pengali * 50, 
                    subtBalance(p2, Saldo), addBalance(p1, Saldo), nl, !.
chanceCard2(Num) :- Num == 13, write('Propertimu telah usang, Propertimu akan disita'), nl,
                    asetProperti(p2, Properti), \+ landmark(Properti), removePosession(p2, Properti), !.
chanceCard2(Num) :- Num == 13, write('Setelah Dilihat-lihat Ternyata Sudah Aman'), nl, !.
chanceCard2(Num) :- Num == 14, write('Ada Tetanggamu yang Membutuhkan Tempat, Jual Propertimu'), nl,
                    asetProperti(p2, Properti), \+ landmark(Properti), nilaiProperti(Properti, Nilai),
                    NilaiAkhir is (Nilai * 0.8), addBalance(p2, NilaiAkhir), !.
chanceCard2(Num) :- Num == 14, write('Ternyata Nanya Doang Beli Kagak'), nl, !.

/* Kartu kalau sudah 3 */
isChangeCard1(X, Num) :- X == 3, write('Kartumu berlebih mau mengambil kartu baru?[y/n]'), nl, read(Answer), 
                        ((Answer == y, retract(card(p1,_LastCard)), !) ; (Answer == n, retract(card(p1, Num)), !) ; 
                        (Answer \= y, Answer \= n, write('Input tidak valid'), nl, isChangeCard1(X, Num), !)),
                        retract(lenCard1(Len)), LenNew is Len - 1, asserta(lenCard1(LenNew)), !.
isChangeCard1(X, _Num) :- X \= 3.
isChangeCard2(X, Num) :- X == 3, write('Kartumu berlebih mau mengambil kartu baru?[y/n]'), nl, read(Answer), 
                        ((Answer == y, retract(card(p2,_LastCard)), !) ; (Answer == n, retract(card(p2, Num)), !) ; 
                        (Answer \= y, Answer \= n, write('Input tidak valid'), nl, isChangeCard2(X, Num), !)), 
                        retract(lenCard2(Len)), LenNew is Len - 1, asserta(lenCard2(LenNew)), !.
isChangeCard2(X, _Num) :- X \= 3.

isPoor(Player, Boolean) :- totalAsset(Player, Balance1),
                            pemain(OtherPlayer),
                            OtherPlayer \= Player,
                           totalAsset(OtherPlayer, Balance2), (Balance1 < (Balance2 * 0.5), Boolean is 1 ; (\+ (Balance1 < (Balance2 * 0.5)), Boolean is 0 )), !.

/* untuk kocok kartu */
runCard :- currentPemain(_P), (lokasiPemain(_P, cc1); lokasiPemain(_P, cc2); lokasiPemain(_P, cc3)),
           isPoor(_P, Boolean), randomNumberForCard(Number, Boolean), 
           ((_P == p1, chanceCard1(Number), lenCard1(X), isChangeCard1(X, Number), !) ; 
           (_P == p2, chanceCard2(Number), lenCard2(X), isChangeCard2(X, Number), !)), !.

/* program untuk print card */
infoCard :- currentPemain(_P), _P == p1, lenCard1(_Len), _Len = 0, write('Kamu tidak memiliki kartu'), nl, !.        
infoCard :- currentPemain(_P), _P == p1, lenCard1(_Len), _Len \= 0,  write('Kartu Kamu : '), nl, nl,
            (currentPemain(_P), card(_P,Temp), cardf(Temp, _Num), write(_Num), nl, fail ), !.
infoCard :- currentPemain(_P), _P == p2, lenCard2(_Len), _Len = 0, write('Kamu tidak memiliki kartu'), nl, !.        
infoCard :- currentPemain(_P), _P == p2, lenCard2(_Len), _Len \= 0,  write('Kartu Kamu : '), nl, nl,
            (currentPemain(_P), card(_P,Temp), cardf(Temp, _Num), write(_Num), nl, fail ), !.