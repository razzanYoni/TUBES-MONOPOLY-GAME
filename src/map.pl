/* Lokasi */


/*Deklarasi Fakta*/

listLokasi([go,a1, gc, a2,cc1,b1,b2,b3,jl,c1,c2,c3,tx1,d1,d2,d3,fp,e1,wc,e2,cc2,f1,f2,f3,wt,g1,g2,g3,tx2,cc3,h1,h2]).

 


/*Deklarasi Rules*/
searchProperti(Tile, [H|_T]) :- H = Tile, !.
searchProperti(Tile, [_H|T]) :- searchProperti(Tile, T).

cekProperti(T, X) :-
% cek kepemilikan properti di tiles tersebut 
    posessionArr(X, L), searchProperti(T, L).


printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Tanah',
                write('Tanah   ').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan1',
                write('Gedung 1').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan2',
                write('Gedung 2').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Bangunan3',
                write('Gedung 3').
printPro(T, P) :- cekProperti(T, P), tingkatanAset(T, Aset), Aset = 'Landmark',
                write('Landmark').
  

printOwner(T,P) :- cekProperti(T,P), tingkatanAset(T, _Aset),write(P), write('      '). 


printBalance(Player) :- balance(Player, X), write(X).

pion(Tile) :- 
    (lokasiPemain(p1, Tile), write(' p1 ') ; write('    ')) , 
    (lokasiPemain(p2, Tile), write(' p2 ') ; write('    ')).


printMap :- nl, nl, 
    write('             '),
                    write('          '),    (printOwner(e1,_);
                                            write('        ')), write(' '),
                                                    write('        '),write(' '),
                                                            (printOwner(e2,_);
                                                            write('        ')),write(' '),
                                                                    write('        '),write(' '),
                                                                            (printOwner(f1,_);
                                                                            write('        ')),write(' '),
                                                                                        (printOwner(f2,_);
                                                                                        write('        ')),write(' '),
                                                                                                (printOwner(f3,_);
                                                                                                write('        ')),         nl,
    write('             '),
                    write('          '),    (printPro(e1,_);
                                            write('        ')),write(' '),
                                                    write('        '),write(' '),
                                                            (printPro(e2,_);
                                                            write('        ')),write(' '),
                                                                    write('        '),write(' '),
                                                                            (printPro(f1,_);
                                                                            write('        ')),write(' '),
                                                                                        (printPro(f2,_);
                                                                                        write('        ')),write(' '),
                                                                                                (printPro(f3,_);
                                                                                                write('        ')),         nl,
    write('    '),  write('          ________________________________________________________________________________'),    nl,
    write('    '),  write('         |   FP   |   E1   |   WC   |   E2   |   CC2  |   F1   |   F2   |   F3   |   WT   |'),   nl,
    write('    '),  write('         |'),pion(fp),write('|'),pion(e1),write('|'),pion(wc),write('|'),pion(e2),write('|'),pion(cc2),write('|'),pion(f1),write('|'),pion(f2),write('|'),pion(f3),write('|'),pion(wt),write('|'), nl,
    write('    '),  write('         |________|________|________|________|________|________|________|________|________|'),   nl,
    write('    '),  (printOwner(d3,_);write('        ')),write(' |   D3   |                                                              |   G1   |'), write(' '),(printOwner(g1,_);write('        ')),write(' '), nl,
    write('    '),  (printPro(d3,_);write('        ')),write(' |'),pion(d3),write('|                              ->                              |'),pion(g1),write('|'), write(' '),(printPro(g1,_);write('        ')),write(' '), nl,
    write('    '),  write('         |________|                                                              |________|'),   nl,
    write('    '),  (printOwner(d2,_);write('        ')),write(' |   D2   |                                                              |   G2   |'), write(' '),(printOwner(g2,_);write('        ')),write(' '),nl,
    write('    '),  (printPro(d2,_);write('        ')),write(' |'),pion(d2),write('|                                                              |'),pion(g2),write('|'), write(' '),(printPro(g2,_);write('        ')),write(' '), nl,
    write('    '),  write('         |________|                                                              |________|'),   nl,
    write('    '),  (printOwner(d1,_);write('        ')),write(' |   D1   |                                                              |   G3   |'), write(' '),(printOwner(g3,_);write('        ')),write(' '), nl,
    write('    '),  (printPro(d1,_);write('        ')),write(' |'),pion(d1),write('|                                                              |'),pion(g3),write('|'), write(' '),(printPro(g3,_);write('        ')),write(' '), nl,
    write('    '),  write('         |________|     ___     _                     ___         _              |________|'),   nl,
    write('    '),  write('         |   TX1  |    | _ )___| |___  _   _ _  ___  | _ \\_ _ ___| |___ __ _     |   TX2  |'),  nl,
    write('    '),  write('         |'),pion(tx1),write('|    | _ / _ | / | || | | ` \\/ _ \\ |  _| `_/ _ | / _ / _` |    |'),pion(tx2),write('|'), nl,
    write('    '),  write('         |________|    |___\\___|_\\_\\ _,_| |_||_\\___/ |_| |_| \\___|_\\___\\__, |    |________|'), nl,
    write('    '),  (printOwner(c3,_);write('        ')),write(' |   C3   |                                                    |___/     |   CC3  |'), nl,
    write('    '),  (printPro(c3,_);write('        ')),write(' |'),pion(c3),write('|                                                              |'),pion(cc3),write('|'), nl,
    write('    '),  write('         |________|                                                              |________|'),   nl,
    write('    '),  (printOwner(c2,_);write('        ')),write(' |   C2   |                                                              |   H1   |'), write(' '),(printOwner(h1,_);write('        ')),write(' '), nl,
    write('    '),  (printPro(c2,_);write('        ')),write(' |'),pion(c2),write('|                                                              |'),pion(h1),write('|'), write(' '),(printPro(h1,_);write('        ')),write(' '), nl,
    write('    '),  write('         |________|                                                              |________|'),   nl,
    write('    '),  (printOwner(c1,_);write('        ')),write(' |   C1   |                                                              |   H2   |'), write(' '),(printOwner(h2,_);write('        ')),write(' '), nl,
    write('    '),  (printPro(c1,_);write('        ')),write(' |'),pion(c1),write('|                             <-                               |'),pion(h2),write('|'), write(' '),(printPro(h2,_);write('        ')),write(' '), nl,
    write('    '),  write('         |________|______________________________________________________________|________|'),   nl,
    write('    '),  write('         |   JL   |   B3   |   B2   |   B1   |   CC1  |   A2   |   GC   |   A1   |   GO   |'),   nl,
    write('    '),  write('         |'),pion(jl),write('|'),pion(b3),write('|'),pion(b2),write('|'),pion(b1),write('|'),pion(cc1),write('|'),pion(a2),write('|'),pion(gc),write('|'),pion(a1),write('|'),pion(go),write('|'), nl,
    write('    '),  write('         |________|________|________|________|________|________|________|________|________|'),   nl,nl,
    write('               '),write('        '),(printOwner(b3,_);write('        ')),write(' '),(printOwner(b2,_);write('        ')),write(' '),(printOwner(b1,_);write('        ')),write(' '),write('        '),write(' '),(printOwner(a2,_);write('        ')),write(' '),write('        '),write(' '),(printOwner(a1,_);write('        ')),write(' '),nl,
    write('               '),write('        '),(printPro(b3,_);write('        ')),write(' '),(printPro(b2,_);write('        ')),write(' '),(printPro(b1,_);write('        ')),write(' '),write('        '),write(' '),(printPro(a2,_);write('        ')),write(' '),write('        '),write(' '),(printPro(a1,_);write('        ')),nl,nl,
    write('Posisi '), nl,
    write('P1 : '), lokasiPemain(p1, X),
        (
            (X == cc1 ; X == cc2 ; X == cc3), write('cc')
            ;
            (X == tx1 ; X == tx2), write('tx')
            ;
            write(X)
        ), nl, write('Saldo Player P1: '), printBalance(p1), nl,nl,
    write('P2 : '), lokasiPemain(p2, Y),
        (
            (Y == cc1 ; Y == cc2 ; Y == cc3), write('cc')
            ;
            (Y == tx1 ; Y == tx2), write('tx')
            ;
            write(Y)
        ), nl, write('Saldo Player P2: '), printBalance(p2),nl,nl,!.



%        |
%Tanah   |
%Gedung 1|
%Gedung 2|
%Gedung 3|
%Landmark|
%p1      |
