/* File : jail.pl */


/* Deklarasi Fakta */

/* ####### Pengecekan Kartu ####### */
    /* cekKartuJail1(L) benar jika player p1 dengan banyak kartu L memiliki Kartu Jail */
cekKartuJail1(Len) :-
    Len == 0,
    false, !.
cekKartuJail1(Len) :-
    Len =\= 0,
    retract(card1(X))
    card(X,_),
    X == 1,
    asserta(card1(X)), !.
cekKartuJail1(Len) :-
    Len =\= 0,
    retract(card1(X)),
    card(X,_)
    X =\= 1,
    assertz(card1(X)).
    Len1 is Len - 1
    cekKartuJail1(Len1).

    /* cekKartuJail2(L) benar jika player p2 dengan banyak kartu L memiliki Kartu Jail */
cekKartuJail2(Len) :-
    Len == 0,
    fail, !.
cekKartuJail2(Len) :-
    Len =\= 0,
    retract(card2(X))
    card(X,_),
    X == 1,
    asserta(card2(X)), !.
cekKartuJail2(Len) :-
    Len =\= 0,
    retract(card2(X)),
    card(X,_)
    X =\= 1,
    assertz(card2(X)).
    Len1 is Len - 1
    cekKartuJail2(Len1).

    /* cekKartu benar jika player memiliki kartu Penjara*/
cekKartuJail :-
    currentPemain(P),
    P == p1,
    retract(lenCard1(Len)),
    asserta(lenCard1(Len)),
    cekKartuJail1(Len).
cekKartuJail :-
    currentPemain(P),
    P == p2,
    retract(lenCard2(Len)),
    asserta(lenCard2(Len)),
    cekKartuJail2(Len).
/* ####### Pengecekan Kartu ####### */

/* ####### Pengecekan Keuangan ####### */
    /* cekBalance benar jika player memiliki cukup uang (>=100) untuk menyuap sipir penjara */
cekBalance :-
    currentPemain(Pemain),
    Pemain == p1,
    retract(balance(p1,X)),
    asserta(balance(p1,X)),
    X >= 100, !.
cekBalance :-
    currentPemain(Pemain),
    Pemain == p2,
    retract(balance(p2,X)),
    asserta(balance(p2,X)),
    X >= 100, !.
/* ####### Pengecekan Keuangan ####### */


/* ####### Output ketika Pemain di penjara ####### */
    /* writeinJail menulis output ketika player berada di penjara  */
    writeinJail :-
        nl,
        write('Anda berada di penjara'), nl.
    
/* ####### Output ketika Pemain di penjara ####### */

/* #######  ####### */
    /*  */
    /*  */
/* #######  ####### */