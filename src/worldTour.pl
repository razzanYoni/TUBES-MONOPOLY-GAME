/* File: jail.pl */

/* Deklarasi Fakta dan Aturan */
/* ======================================== Pengecekan Duid ======================================== */
    /* isDuitWTcukup(X) benar jika pemain P memiliki uang yang cukup untuk melakukan world tour */
isDuitWTcukup(Pemain) :-
    balance(Pemain, X),
    X >= 50, !.
/* ======================================== Pengecekan Duid ======================================== */

/* ======================================== Write list lokasi ======================================== */
tulisListLokasi([]) :-
tulisListLokasi([H|_T])
    H == wt,
    write('Anda ada disini(wt) '),
    tulisListLokasi(_T).
tulisListLokasi([H|_T]) :-
    H \== wt,
    write(H), write(' '),
    tulisListLokasi(_T). 
/* ======================================== Write list lokasi ======================================== */

/* ======================================== World Tour ======================================== */
    /* wordlTour benar jika currentPemain(P); P dapat berpindah kemanapun */
worldTour :-
    currentPemain(Pemain),
    (
        isDuitWTcukup(Pemain),
            listLokasi(Lokasi),
            printMap,
            write('Selamat datang di World Tour Boku no Prolog!'), nl,
            (
                repeat,
                write('Masukkan lokasi yang ingin dikunjungi: '),
                read(InputLoc),
                (
                    /* wt */
                    InputLoc == wt,
                    nl, 
                    write('Anda sudah berada di World Tour'), nl,
                    write('Silakan pilih tempat yang lain'), nl, fail
                    ;

                    /* valid */
                    InputLoc \== wt,
                    Lokasi(InputLoc),
                    subtBalance(Pemain, 50),
                    moveToLocation(Pemain, InputLoc),
                    wirte('Anda telah sampai di '), write(InputLoc), nl, !.

                    /* non-valid */
                    \+ Lokasi(InputLoc),
                    write(InputLoc), write(' bukan lokasi yang valid'), nl,
                    write('Silakan pilih tempat berikut :'), nl,
                    tulisListLokasi(Lokasi), nl, fail
                )
            )
        ;
        write('Uangmu tidak cukup untuk melakukan World Tour!'), nl
    ), !.
/* ======================================== World Tour ======================================== */