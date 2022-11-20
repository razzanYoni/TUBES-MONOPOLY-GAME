/* Lokasi */
/*Deklarasi Fakta*/

tiles([go,a1,a2,a3,cc,b1,b2,b3,jl,c1,c2,c3,tx,d1,d2,d3,fp,e1,e2,e3,cc,f1,f2,f3,wt,g1,g2,g3,tx,cc,h1,h2]).

/*Deklarasi Rules*/

printmap :- nl, nl,
    write('         ____________________________________________'), nl,
    write('        | FP | E1 | E2 | E3 | CC | F1 | F2 | F3 | WT |'), nl,
    write('        |____|____|____|____|____|____|____|____|____|'), nl,
    write('        | D3 |                                  | G1 |'), nl,
    write('        |____|               ->                 |____|'), nl,
    write('        | D2 |                                  | G2 |'), nl,
    write('        |____|                                  |____|'), nl,
    write('        | D1 |                                  | G3 |'), nl,
    write('        |____|                                  |____|'), nl,
    write('        | TX |          Let\'s Get Poor          | TX |'), nl,
    write('        |____|                                  |____|'), nl,
    write('        | C3 |                                  | CC |'), nl,
    write('        |____|                                  |____|'), nl,
    write('        | C2 |                                  | H1 |'), nl,
    write('        |____|                                  |____|'), nl,
    write('        | C1 |               <-                 | H2 |'), nl,
    write('        |____|__________________________________|____|'), nl,
    write('        | JL | B3 | B2 | B1 | CC | A3 | A2 | A1 | GO |'), nl,
    write('        |____|____|____|____|____|____|____|____|____|'), nl,nl,
    write('Posisi '), nl,
    write('P1 : '), lokasiPemain(p1, X), 
        (
            (X == cc1 ; X == cc2 ; X == cc3), write('cc')
            ;
            (X == tx1 ; X == tx2), write('tx')
            ;
            write(X)
        ), nl,
    write('P2 : '), lokasiPemain(p2, X), 
        (
            (X == cc1 ; X == cc2 ; X == cc3), write('cc')
            ;
            (X == tx1 ; X == tx2), write('tx')
            ;
            write(X)
        ), nl,
