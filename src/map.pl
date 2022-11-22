/* Lokasi */

:- [player].

/*Deklarasi Fakta*/

listLokasi([go,a1, gc, a2,cc1,b1,b2,b3,jl,c1,c2,c3,tx1,d1,d2,d3,fp,e1,e2,e3,cc2,f1,f2,f3,wt,g1,g2,g3,tx2,cc3,h1,h2]).

 


/*Deklarasi Rules*/
searchProperti(Tile, [H|T]) :- H = Tile, !.
searchProperti(Tile, [H|T]) :- searchProperti(Tile, T).

cekProperti(T, X) :-
% cek kepemilikan properti di tiles tersebut 
    posessionArr(X, L), searchProperti(T, L).

printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset),
                write('|'),write(P), write('| '), write(Aset).

printAtap1(T,P) :- cekProperti(T,P), tingkatanAset(T, Aset), write(' /   \\ ').


printMap :- nl, nl,
    write('         ________________________________________________________________________________'), nl,
    write('        |   FP   |   E1   |   E2   |   E3   |   CC   |   F1   |   F2   |   F3   |   WT   |'), nl,
    write('        |        |        |        |        |        |        |        |        |        |'), nl,
    write('        |________|________|________|________|________|________|________|________|________|'), nl,
    write('        |   D3   |                                                              |   G1   |'), nl,
    write('        |        |              ->                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   D2   |                                                              |   G2   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   D1   |                                                              |   G3   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   TX   |                                                              |   TX   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   C3   |                                                              |   CC   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   C2   |                                                              |   H1   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|                                                              |________|'), nl,
    write('        |   C1   |               <-                                             |   H2   |'), nl,
    write('        |        |                                                              |        |'), nl,
    write('        |________|______________________________________________________________|________|'), nl,
    write('        |   JL   |   B3   |   B2   |   B1   |   CC   |   A3   |   GC   |   A1   |   GO   |'), nl,
    write('        |        |        |        |        |        |        |        |        |        |'), nl,
    write('        |________|________|________|________|________|________|________|________|________|'), nl,
    write('Posisi '), nl,
    write('P1 : '), lokasiPemain(p1, X), 
        (
            (X == cc1 ; X == cc2 ; X == cc3), write('cc')
            ;
            (X == tx1 ; X == tx2), write('tx')
            ;
            write(X)
        ), nl,
    write('P2 : '), lokasiPemain(p2, Y),
        (
            (Y == cc1 ; Y == cc2 ; Y == cc3), write('cc')
            ;
            (Y == tx1 ; Y == tx2), write('tx')
            ;
            write(Y)
        ), nl.
