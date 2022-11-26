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


printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Tanah',
                write('Tanah').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan 1',
                write('Rumah 1 ').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan 2',
                write('Rumah 2 ').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan 3',
                write('Rumah 3 ').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Landmark',
                write('Landmark').
  

printOwner(T,P) :- cekProperti(T,P), tingkatanAset(T, Aset),write(P), write('      '). 


printMap :- nl, nl,
    write('    '),write('             ________________________________________________________________________________'), nl,
    write('    '),write('            |   FP   |   E1   |   E2   |   E3   |   CC   |   F1   |   F2   |   F3   |   WT   |'), nl,
    write('    '),write('            |        |        |        |        |        |        |        |        |        |'), nl,
    write('    '),write('            |________|________|________|________|________|________|________|________|________|'), nl,
    write('    '),(printOwner(d3,_);write('        ')),write('    |   D3   |                                                              |   G1   |'), (printOwner(g1,_);write('        ')), nl,
    write('    '),(printPro(d3,_);write('        ')),write('    |        |                                                              |        |'), (printPro(g1,_);write('        ')), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),(printOwner(d2,_);write('        ')),write('    |   D2   |                                                              |   G2   |'), (printOwner(g2,_);write('        ')),nl,
    write('    '),(printPro(d2,_);write('        ')),write('    |        |                                                              |        |'), (printPro(g2,_);write('        ')), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),(printOwner(d1,_);write('        ')),write('    |   D1   |                                                              |   G3   |'), (printOwner(g3,_);write('        ')), nl,
    write('    '),(printPro(d1,_);write('        ')),write('    |        |                                                              |        |'), (printPro(g3,_);write('        ')), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),write('            |   TX   |                                                              |   TX   |'), nl,
    write('    '),write('            |        |                                                              |        |'), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),(printOwner(c3,_);write('        ')),write('    |   C3   |                                                              |   CC   |'), nl,
    write('    '),(printPro(c3,_);write('        ')),write('    |        |                                                              |        |'), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),(printOwner(c2,_);write('        ')),write('    |   C2   |                                                              |   H1   |'), (printOwner(h1,_);write('        ')), nl,
    write('    '),(printPro(c2,_);write('        ')),write('    |        |                                                              |        |'), (printPro(h1,_);write('        ')), nl,
    write('    '),write('            |________|                                                              |________|'), nl,
    write('    '),(printOwner(c1,_);write('        ')),write('    |   C1   |                                                              |   H2   |'), (printOwner(h2,_);write('        ')), nl,
    write('    '),(printPro(c1,_);write('        ')),write('    |        |                                                              |        |'), (printPro(h2,_);write('        ')), nl,
    write('    '),write('            |________|______________________________________________________________|________|'), nl,
    write('    '),write('            |   JL   |   B3   |   B2   |   B1   |   CC   |   A3   |   GC   |   A1   |   GO   |'), nl,
    write('    '),write('            |        |        |        |        |        |        |        |        |        |'), nl,
    write('    '),write('            |________|________|________|________|________|________|________|________|________|'), nl,
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
        ), nl,!.
