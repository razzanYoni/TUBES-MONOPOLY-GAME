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

/* ======================================== Penanganan input ketika dalam penjara ======================================== */
    /* usingCard(P, X) benar jika  P memiliki kartu X */
usingCard(Pemain, X) :-
    retract(card(Pemain, X)),
    retractall(jail(Pemain)),!.

    /* useJailCard benar jika currentPemain(P), P berada di penjara dan usingCard(P, X) benar */
useJailCard :-
    currentPemain(Pemain),
    jail(Pemain),  
    cardf(1, Y),
    (   
        card(Pemain, 1),
        usingCard(Pemain, 1),
        write('Kamu menggunakan '), write(Y), write('!'), nl
        ;
        write('Kamu tidak memiliki kartu '), write(Y), write('!'), nl, fail
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
        write('Sipir: Berani sekali kamu menyuapku!! (minimal 100 dollar lahh)'), nl, fail
    ), !.
suapSipir :-
    currentPemain(Pemain),
    \+ jail(Pemain),
    write('Kamu tak di penjara, buat apa kamu menyuap sipir??'), nl, !.
/* ======================================== Penanganan input ketika dalam penjara ======================================== */

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
    ),

    (repeat,
            write('Masukkan perintah: '),
            read(InputString),
            (
                /* Switch buat command */
                /* Help */
                InputString == help,
                nl, write('Perintah yang tersedia'), nl,
                write('lempar.: mulai melempar dadu'), nl,
                write('useJailCard.: mulai melempar dadu'), nl,
                write('suapSipir.: mulai melempar dadu'), nl,
                write('locationDetail.: mengecek informasi lokasi yang ada'), nl,
                write('propertyDetail.: mengecek informasi properti yang ada'), nl,
                write('playerDetail.: mengecek informasi properti yang ada'), nl,
                write('debug.: keluar dari overlay game untuk memasukkan command secara direct'), nl, nl, fail
                ;

                /* Lempar */
                InputString == lempar,
                throwDice,
                (
                    /* Kalo gak double switch and stop */
                    \+ double(_Berapapun),
                    switchPlayer, !
                    ;
                    double(_Berapapun)
                ),
                checkLokasi(Pemain), !
                ;

                /* Use Jail Card */
                InputString == useJailCard,
                useJailCard
                ;

                /* Use Suap Sipir */
                InputString == suapSipir,
                suapSipir
                ;

                /* Check Location Detail */
                InputString == locationDetail,
                (repeat,
                    (
                        nl, write('Masukkan nama lokasi: '), read(InputLokasi),
                        (
                            checkLocationDetail(InputLokasi),!
                        )
                    )
                )
                ;

                /* Check Property Detail */
                InputString == propertyDetail,
                (repeat,
                    (
                        nl, write('Masukkan nama lokasi: '), read(InputLokasi),
                        (
                            checkPropertyDetail(InputLokasi),!
                        )
                    )
                )
                ;

                /* Check Property Player */
                InputString == playerDetail,
                (repeat,
                    (
                        nl, write('Masukkan nama pemain: '), read(_InputPlayer),
                        (
                            checkPlayerDetail(_InputPlayer),!
                        )
                    )
                )
                ;

                /* Debug mode*/
                InputString == debug,
                asserta(debug(debugging)),
                nl, write('Masuk ke mode debug'), nl, nl, !
                ;

                /* Default */
                InputString \= help,
                nl, write('Input tidak valid'), nl, nl, fail
            
            )
        ),!.

        


/* Jika user tidak dipenjara, ditile penjara, dan masuk gilirannya */
writeinJail :-
    currentPemain(Pemain),
    \+ jail(Pemain),
    write('hanya berkunjung...'),nl, !.
/* ======================================== Output ketika Pemain di penjara ======================================== */

