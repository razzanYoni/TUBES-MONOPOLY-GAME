/*Dynamic Predicates*/
:- dynamic(n_true/1).
:- dynamic(hadiah_pemain/1).
:- dynamic(bermain/1).


/*Deklarasi Fakta*/
/*hadiah(Hadiah1, Hadiah2, Hadiah3) : Deklarasi besaran hadiah jika player bisa menebak dengan benar 1,2 atau 3 kali*/
hadiah(150, 300, 500).

/*Deklarasi Rules*/
/*lempar_koin(Sisi): Melakukan randomize, dan memperoleh angka 1(HEAD) atau 0(TAIL)*/
lempar_koin(Sisi) :- randomize, get_seed(Seed), Sisi is (Seed mod 2)+1, !.

/* guessing(N_true, Guess, Hadiah_pemain) : Predikat untuk berjalannya game, terminasi saat tebakan salah, tebakan pemain benar 3 kali, atau pemain mengkaim hadiah, */
guessing(N_true,Guess):- lempar_koin(Sisi), Sisi =\= Guess, asserta(hadiah_pemain(0)), asserta(bermain(2)),
                            write('Sayang sekali tebakanmu salah! :('), nl, !.
guessing(2, Guess) :- lempar_koin(Sisi), Sisi == Guess, hadiah(_,_,Hadiah3), asserta(hadiah_pemain(Hadiah3)), asserta(bermain(2)),
                            write('Selamat!! Kamu berhasil memenangkan Game Center dan mendapatkan hadiah $'), write(Hadiah3), nl, !.
guessing(1, Guess) :- lempar_koin(Sisi), Sisi == Guess, hadiah(_,Hadiah2, _), asserta(hadiah_pemain(Hadiah2)), asserta(n_true(2)),
                            write('Selamat!! Kamu berhasil menebak dengan benar, hadiah yang berhasil dikumpulkan: $'), write(Hadiah2), nl, nl,
                            guessing_flow, !.
guessing(0, Guess) :- lempar_koin(Sisi), Sisi == Guess, hadiah(Hadiah1, _, _), asserta(hadiah_pemain(Hadiah1)), asserta(n_true(1)),
                            write('Selamat!! Kamu berhasil menebak dengan benar, hadiah yang berhasil dikumpulkan: $'), write(Hadiah1), nl, nl,
                            guessing_flow, !.

/*inputGuessing : Prosedur untuk menangani input dari pemain*/
inputGuessing :- bermain(Stat), Stat =\= 1, hadiah_pemain(Hadiah),
                write('Terima Kasih telah bermain di Game Center!  Hadiah yang berhasil dikumpulkan: $'), write(Hadiah), nl, !.

inputGuessing :- write('Sisi manakah yang akan muncul?? (masukkan angka 1 atau 2)'), nl,
                write('1. HEAD'), nl,
                write('2. TAIL'), nl,
                write('Guess: '), read(Guess), n_true(N_true), guessing(N_true, Guess).

/*guessing_flow : Prosedur untuk mengatur jalannya permainan di Game Center*/
guessing_flow :- write('Siap untuk mendapatkan hadiah yang lebih besar?? (masukkan angka 1 atau 2)'), nl,
                write('1. Ya, Lanjut Bermain'), nl,
                write('2. Tidak, Klaim Hadiah'), nl,
                write('Pilihan: '), read(Stat), nl, 
                asserta(bermain(Stat)), inputGuessing.

/*playGameCenter : Memulai permainan di game center*/
playGameCenter :- retractall(n_true(N)), retractall(bermain(S)), retractall(hadiah_pemain(H)), 
                    asserta(n_true(0)), asserta(bermain(1)), asserta(hadiah_pemain(0)),inputGuessing.
                    /*Mau ditambahin subtBalance dan addBalance*/