/*File Main*/
:-include('lokasinProperti.pl').
:-include('dadu.pl').
:-include('map.pl').
:-include('player.pl').

startGame:-
    printmap,
    
    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,
    
    (repeat,
    write('Masukkan perintah: '),
    read(InputString),
    (
        /* Switch buat command */
        /* Help */
        InputString = help,
        nl, write('Perintah yang tersedia'), nl,
        write('lempar.: mulai melempar dadu'), nl, nl, fail
        ;

        /* Lempar */
        InputString = lempar,
        throwDice,
        (
            /* Kalo gak double switch and stop */
            \+ double(Berapapun),
            switchPlayer, !
            ;
            1 = 1
        )
        ;


        /* Next */
        InputString = test, nl, 
        write('Test brehasil')
        ;


        /* Default */
        InputString \= help,
        nl, write('Input tidak valid'), nl, nl, fail
    
    )
    ),

    checkBangkrut(X),

    /*Command Closingan kalo kalah di sini*/
    (bangkrut(X, true)

    
    ;
    startGame).


