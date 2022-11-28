/* File: jail.pl */

/* Deklarasi Fakta dan Aturan */
/* ======================================== Pengecekan Duid ======================================== */
    /* isDuitWTcukup(X) benar jika pemain P memiliki uang yang cukup untuk melakukan world tour */
isDuitWTcukup(Pemain) :-
    balance(Pemain, X),
    X >= 50, !.
/* ======================================== Pengecekan Duid ======================================== */

/* ======================================== Write list lokasi ======================================== */
tulisListLokasi([]).
tulisListLokasi([H|_T]):-
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
            write('Selamat datang di World Tour Boku no Prolog!       '), nl,
            write('__      __       _    _   _____                    '), nl,
            write('\\ \\    / /__ _ _| |__| | |_   _|__ _  _ _ _      '), nl,
            write(' \\ \\/\\/ / _ \\ \'_| / _` |   | |/ _ \\ || | \'_|'), nl,
            write('  \\_/\\_/\\___/_| |_\\__,_|   |_|\\___/\\_,_|_|   '), nl, nl,
            (
                repeat,
                write('Masukkan lokasi yang ingin dikunjungi: '),
                read(InputLoc),
                (
                    /* wt */
                    InputLoc == wt,
                    lokasi(InputLoc),
                    nl, 
                    write('Anda sudah berada di World Tour'), nl,
                    write('Silakan pilih tempat yang lain'), nl, fail
                    ;

                    /* valid */
                    InputLoc \== wt,
                    lokasi(InputLoc),
                    subtBalance(Pemain, 50),
                    moveToLocation(Pemain, InputLoc),
                    write('Anda telah sampai di '), write(InputLoc), nl,
                    checkLokasi(Pemain), !
                    ;

                    /* non-valid */
                    \+ lokasi(InputLoc),
                    write(InputLoc), write(' bukan lokasi yang valid'), nl,
                    write('Silakan pilih tempat berikut :'), nl,
                    tulisListLokasi(Lokasi), nl, fail
                )
            )
        ;
        \+ isDuitWTcukup(Pemain),
        write('Uangmu tidak cukup untuk melakukan World Tour!'), nl
    ), !.
/* ======================================== World Tour ======================================== */