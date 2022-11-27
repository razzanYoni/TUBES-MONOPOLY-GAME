/*File Main*/
:-include('lokasinProperti.pl').
:-include('dadu.pl').
:-include('map.pl').
:-include('player.pl').
:-include('gameCenter.pl').
:-include('kartu.pl').
:-include('gameCenter.pl').
:-include('pajak.pl').

:-dynamic(debug/1).
debug(debugging).

inputHandling:-
    (repeat,
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
                    \+ double(Berapapun),
                    switchPlayer, !
                    ;
                    1 = 1
                ),
                checkLokasi(Pemain), !
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
                        nl, write('Masukkan nama pemain: '), read(InputPlayer),
                        (
                            checkPlayerDetail(Pemain),!
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
        ).


startGameIn:-
    printMap,
    
    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,
        
    inputHandling,

    checkBangkrut(X),
    bayarPajak(X),

    /*Command Closingan kalo kalah di sini*/
    
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
