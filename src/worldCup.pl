/* File : worldCup.pl */

:- dynamic(worldCup/2).

/* ======================================== Initwcoutput ======================================== */
    /* outputWc benar jika menampilkan pada layar */
    /*  */
/* ======================================== Initwcoutput ======================================== */

/* ======================================== Pemain Lawan ======================================== */
    /* pemainLawan(P1,P2) benar jika P2 adalah pemain lawan dari P1 */
pemainLawan(P1, P2) :-
    pemain(P2),
    P1 \== P2.
/* ======================================== Pemain Lawan ======================================== */



/* ======================================== Initwcoutput ======================================== */
    /* worldCup benar jika currentPemain(P) ada di tile wc dan telah memilih 1 tile property untuk di upgrade */
worldCup :-
    currentPemain(Pemain),
    lokasiPemain(Pemain, wc),
    (
        repeat,
        write('Masukkan properti yang akan menjadi tuan rumah: '),
        read(InputProp),
        (
            /* valid */
            asetProperti(Pemain, InputProp),
            asserta(worldCup(Pemain, InputProp)),
            asserta(worldCup(Pemain, InputProp)),
            asserta(worldCup(Pemain, InputProp)),
            write(InputProp), write(' menjadi Tuan rumah World cup'), nl,
            write('di Dunia Boku no Prolog!'), nl
            write('(akhirnya cewek-cewek akan terpukau denganku!!)'),nl,
            write('pikirmu'), nl, !
            ;

            /* non valid */
            \+ asetProperti(Pemain, InputProp),
            pemainLawan(Pemain, Lawan),
            (
                /* termasuk lokasi */
                lokasi(InputProp),
                \+ pemainLawan(Pemain, Lawan),
                write('Buat apa naikin pajak tile ini....'), nl,
                write(Lawan), write('menggelengkan kepala')
                ;

                /* termasuk properti lawan */
                \+ lokasi(InputProp),
                asetProperti(Lawan, InputProp),
                write('Kamu ingin mengadakan World Cup di lokasi musuh!!')
                write(Lawan), write('menatap sinis padamu'), nl
                ;

                /* tidak termasuk properti lawan atau pun lokasi */
                properti(InputProp),
                \+ lokasi(InputProp),
                \+ asetProperti(Lawan, InputProp),
                write(InputProp), write(' belum dimiliki siapapun, termasuk dirimu!'), nl

                /* tidak termasuk semuanya */
                \+ properti(InputProp),
                \+ lokasi(InputProp),
                write(InputProp), write(' bukanlah properti yang valid!'), nl
            )
        )   
    )


worldCup :-
    currentPemain(Pemain),
    \+ lokasiPemain(Pemain, wc),
    write('Hmmmm kamu tidak berada di World Cup...'), nl,
    write('cie pengen banget naikin harga properti'), nl, !.
    write('(duidmu dikit ya)'), nl, !.
/* ======================================== Initwcoutput ======================================== */