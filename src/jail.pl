/* File : jail.pl */

/* Deklarasi Fakta dan Aturan */
/* ======================================== Pengecekan Kartu ======================================== */
    /* card(P,Y) benar jika player P memiliki kartu X --kartu.pl */
/* ======================================== Pengecekan Kartu ======================================== */

/* ======================================== Pengecekan Duit ======================================== */
    /* cekBalance(P,X) benar jika player P memiliki X uang yang cukup untuk menyuap sipir penjara (>=100)*/
cekBalance(Pemain) :-
    balance(Pemain,X),
    X >= 100, !.
/* ======================================== Pengecekan Duit ======================================== */

/* ======================================== Output ketika Pemain di penjara ======================================== */
    /* writeinJail menulis output ketika player berada di penjara  */
    /* Jika user dipenjara, ditile penjara, dan masuk gilirannya */
writeinJail :-
    currentPemain(Pemain),
    jail(Pemain),
    write('Anda berada di penjara!!!'), nl,
    write('pilih input berikut untuk keluar: '), nl,
        write('lempar       : menggunakan keburuntungan double dadu untuk keluar dari penjara'), nl,
    (
        card(Pemain, 1), write('useJailCard : menggunakan kartu Jail'), nl
        ;
        write('useJailCard  : (kamu tidak memilikinya :\'('), nl
    ),
    (
        cekBalance(Pemain), write('suapSipir : menggunakan uang untuk menyuap sipir!'), nl
        ;
        write('suapSipir    : (uangmu tidak cukup!) '), nl
    ), !.
    /* Jika user tidak dipenjara, ditile penjara, dan masuk gilirannya */
    writeinJail :-
        currentPemain(Pemain),
        \+ jail(Pemain),
        write('hanya berkunjung...'),nl, !.
/* ======================================== Output ketika Pemain di penjara ======================================== */

/* ======================================== Penanganan input ketika dalam penjara ======================================== */
    /* usingCard(P, X) benar jika  P memiliki kartu X */
    usingCard(Pemain, X) :-
        retract(card(Pemain, X)), !.

    /* useJailCard benar jika currentPemain(P), P berada di penjara dan usingCard(P, X) benar */
    useJailCard :-
        currentPemain(Pemain),
        jail(Pemain),  
        cardf(1, Y),
        (   
            usingCard(Pemain, 1), 
            write('Kamu menggunakan '), write(Y), write('!'), nl
            ;
            write('Kamu tidak memiliki kartu '), write(Y), write('!'), nl
        ), !.
    useJailCard :-
        currentPemain(Pemain),
        \+ jail(Pemain),
        write('Kamu tidak berada di penjara...'), nl, !.        

    /* suapSipir benar jika currentPemain(P), P berada di penjara dan cekBalance(P,X) benar */
    suapSipir :-
        currentPemain(Pemain),
        jail(Pemain),
        (
            cekBalance(Pemain),
            subtBalance(Pemain, 100),
            retractall(jail(Pemain)),
            write('Sipir tertarik dengan uang yang kamu berikan'), nl,
            write('Kamu berhasil keluar dari penjara!'), nl,
            write('rasa bersalah menghantui dirimu...'), nl
            ;
            write('kamu menjulurkan tangan berisi uang'), nl,
            write('Sipir: Berani sekali kamu menyuapku!! (minimal 100 dollar lahh)'), nl
        ), !.
    suapSipir :-
        currentPemain(Pemain),
        \+ jail(Pemain),
        write('Kamu tak di penjara, buat apa kamu menyuap sipir??'), nl, !.
/* ======================================== Penanganan input ketika dalam penjara ======================================== */