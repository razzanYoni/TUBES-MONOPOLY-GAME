/*File Main*/
:-include('lokasinProperti.pl').
:-include('dadu.pl').
:-include('map.pl').
:-include('player.pl').
:-include('gameCenter.pl').
:-include('kartu.pl').
:-include('jail.pl').
:-include('worldTour').
:-include('worldCup').


:-dynamic(debug/1).
debug(debugging).

inputHandling:-
    currentPemain(Pemain),
    (\+ jail(Pemain),
        repeat,
            write('Masukkan perintah: '),
            read(InputString),
            (
                /* Switch buat command */
                /* Help */
                InputString == help,
                nl, write('Perintah yang tersedia'), nl,
                write('lempar.: mulai melempar dadu'), nl,
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
                    checkLokasi(Pemain),
                    switchPlayer, !
                    ;
                    double(_Berapapun),
                    nl, write('Dobel!'), nl,
                    checkLokasi(Pemain), !
                )
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
                InputString \= help, InputString \= lempar,
                nl, write('Input tidak valid'), nl, nl, fail
            
            )
        )
        
    ;

    (   jail(Pemain),
        repeat,
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
                    checkLokasi(Pemain),
                    switchPlayer, !
                    ;
                    double(_Berapapun),
                    nl, write('Dobel!'), nl,
                    checkLokasi(Pemain), !
                )
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
        ),!
    .


startGameIn:-
    printMap,

    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,
        
    inputHandling,
    
    (bangkrut(X, true)
    ;
    debug(debugging)
    ;
    fail,!).


startGame:-
    retractall(debug(_Debugging)),
    (repeat,
       startGameIn
    ).
