/* File : worldCup.pl */

:- dynamic(worldCupCurrent/2).

/* ======================================== Initwcoutput ======================================== */
    /* outputWc benar jika menampilkan pada layar */
outputWc :-
    write('__      __       _    _   _____             '), nl,
    write('\\ \\    / /__ _ _| |__| | |_   _|__ _  _ _ _ '), nl,
    write(' \\ \\/\\/ / _ \\ \'_| / _` |   | |/ _ \\ || | \'_|'), nl,
    write('  \\_/\\_/\\___/_| |_\\__,_|   |_|\\___/\\_,_|_|  '), !.
/* ======================================== Initwcoutput ======================================== */

/* ======================================== Pemain Lawan ======================================== */
    /* pemainLawan(P1,P2) benar jika P2 adalah pemain lawan dari P1 */
pemainLawan(P1, P2) :-
    pemain(P1),
    pemain(P2),
    P1 \== P2.
/* ======================================== Pemain Lawan ======================================== */



/* ======================================== Initwcoutput ======================================== */
    /* worldCup benar jika currentPemain(P) ada di tile wc dan telah memilih 1 tile property untuk di upgrade */
worldCup :-
    currentPemain(Pemain),
    lokasiPemain(Pemain, wc),
    pemainLawan(Pemain, Lawan),
    (
        repeat,
        write('Masukkan properti yang akan menjadi tuan rumah: '),
        read(InputProp),
        (
            /* valid */
            asetProperti(Pemain, InputProp),
            asserta(worldCupCurrent(Pemain, InputProp)),
            asserta(worldCupCurrent(Pemain, InputProp)),
            asserta(worldCupCurrent(Pemain, InputProp)),
            write(InputProp), write(' menjadi Tuan rumah World cup'), nl,
            write('di Dunia Boku no Prolog!'), nl,
            write('(akhirnya cewek-cewek akan terpukau denganku!!)'),nl,
            write('pikirmu..'), nl, !
            ;

            /* jika ingin keluar */
            InputProp == cancel
            ;

            /* non valid */
            /* termasuk lokasi */
            lokasi(InputProp),
            \+ properti(InputProp),
            write('Buat apa naro world cup di tile ini....'), nl,
            write(Lawan), write(' menggelengkan kepala'), nl, fail
            ;

            /* termasuk properti lawan */
            asetProperti(Lawan, InputProp),
            write('Kamu ingin mengadakan World Cup di lokasi musuh!!'), nl,
            write(Lawan), write(' menatap sinis padamu'), nl, fail
            ;

            /* bukan properti siapapun */
            properti(InputProp),
            \+ asetProperti(Pemain, InputProp),
            \+ asetProperti(Lawan, InputProp),
            write(InputProp), write(' belum dimiliki siapapun, termasuk dirimu!'), nl, fail
            ;

            /* tidak termasuk semuanya */
            \+ lokasi(InputProp),
            write(InputProp), write(' bukanlah properti yang valid!'), nl, fail
        )   
    ),!.


worldCup :-
    currentPemain(Pemain),
    \+ lokasiPemain(Pemain, wc),
    write('Hmmmm kamu tidak berada di World Cup...'), nl,
    write('cie pengen banget naikin harga properti'), nl,
    write('(duidmu dikit ya)'), nl, !.
/* ======================================== Initwcoutput ======================================== */