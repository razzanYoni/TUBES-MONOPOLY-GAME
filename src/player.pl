/*DEPENDENCY KE lokasinproperti.pl*/


/*
TODO
-Tambahin angel card waktu move
-Tambahin detektor landing waktu move
-Tambahin aksi landing waktu move
-Integrasiin fitur dari non properti
*/


/*DATA Pemain*/

/*Current pemain*/
:-dynamic(currentPemain/1).
currentPemain(p1).
/*predikat pemain*/
pemain(p1).
pemain(p2).
/*data lokasiPemain*/
:-dynamic(lokasiPemain/2).
lokasiPemain(p1, go).
lokasiPemain(p2, go).
/*data duit*/
:-dynamic(balance/2).
balance(p1, 300).
balance(p2, 300).
/*data kondisi bangkrut*/
:-dynamic(bangkrut/2).
bangkrut(p1, false).
bangkrut(p2, false).
/*data properti*/
:-dynamic(asetProperti/2).
:-dynamic(tingkatanAset/2).
/*data properti yang dimiliki dalam array*/
    /*ini gw perlu buat ngitung asset, soalnya susah rekursinya kalo gak pake array*/
:-dynamic(posessionArr/2).
/*posessionArr(p1, [a1,a2,a3]).*/
/*posessionArr(p2, []).*/
:-dynamic(lewatGO/2).
lewatGO(p1, 0).
lewatGO(p2, 0).


/*TEMP*/
asetProperti(p2, a1).
asetProperti(p2, a2).
asetProperti(p2, a3).
asetProperti(p2, b1).
asetProperti(p2, b2).
asetProperti(p2, b3).
asetProperti(p2, c1).
asetProperti(p2, c2).
asetProperti(p2, c3).
asetProperti(p2, d1).
asetProperti(p2, d2).
asetProperti(p2, d3).

tingkatanAset(a1, 'Tanah').
tingkatanAset(a2, 'Tanah').
tingkatanAset(a3, 'Tanah').
tingkatanAset(b1, 'Tanah').
tingkatanAset(b2, 'Tanah').
tingkatanAset(b3, 'Tanah').
posessionArr(p1, [a1,a2,a3]).
posessionArr(p2, [b1,b2,b3]).
listLokasi([go,a1,a2,a3,cc1,b1,b2,b3,jl,c1,c2,c3,tx1,d1,d2,d3,fp,e1,e2,e3,cc2,f1,f2,f3,wt,g1,g2,g3,tx2,cc3,h1,h2]).
/*AKHIR TEMP*/


/*Basic-----------------------------------------------*/
changeBalance(Pemain, New):-
    /*ganti duit direct*/
    pemain(Pemain),
    retract(balance(Pemain, _X)),
    asserta(balance(Pemain, New)).
addBalance(Pemain, Amount):-
    /*ganti duit ditambahin*/
    pemain(Pemain),
    balance(Pemain, Old),
    New is Old + Amount,
    changeBalance(Pemain, New).
subtBalance(Pemain, Amount):-
    /*ganti duit dikurangin*/
    pemain(Pemain),
    balance(Pemain, Old),
    New is Old - Amount,
    changeBalance(Pemain, New).

changeLokasiPemain(Pemain, New):-
    /*ganti lokasi direct*/
    pemain(Pemain),
    retract(lokasiPemain(Pemain, _X)),
    asserta(lokasiPemain(Pemain, New)).

switchPlayer:-
    currentPemain(X),
    X == p1,
    retract(currentPemain(_)),
    asserta(currentPemain(p2)).
switchPlayer:-
    currentPemain(X),
    X == p2,
    retract(currentPemain(_)),
    asserta(currentPemain(p1)).


/*ganti lokasiPemain dari nilai integer*/
inNextLocations(_Pemain, H, [H|T], T).
    /*rekursif untuk basis jika Head = Lokasi*/
inNextLocations(Pemain, LokasiPemain, [_H|T], X):-
    /*rekursif untuk basis jika Head != Lokasi*/
    inNextLocations(Pemain, LokasiPemain, T, X).
nextLocations(Pemain, Output):-
    /*rekursif untuk nyari array elemen selanjutnya di array berdasarkan posisi sekarang*/
    lokasiPemain(Pemain, X),
    listLokasi(ListLokasi),
    inNextLocations(Pemain, X, ListLokasi, Output).

/*Check tempat landing buat move, masukin command sesuai keperluan*/
/*Non Properti*/
landingJail:-
    1 = 1.
landingCC:-
    1 = 1.
landingWT:-
    1 = 1.
landingTX:-
    1 = 1.
landingFP:-
    1 = 1.
landingGO:-
    1 = 1.

landingNonProperti(Pemain):-
    lokasiPemain(Pemain, Lokasi),
    (
        Lokasi == jl,
        nl , write('Masuk penjara'), nl, nl,
        landingJail
        ;
        (Lokasi == cc1;Lokasi == cc2;Lokasi == cc3),
        nl , write('Masuk chance card'), nl, nl,
        landingCC
        ;
        (Lokasi == tx1;Lokasi == tx2),
        nl , write('Masuk pajak'), nl, nl,
        landingCC
        ;
        Lokasi == wt,
        nl , write('Masuk world tour'), nl, nl,
        landingWT
        ;
        Lokasi == fp,
        nl , write('Masuk parkir gratis'), nl, nl,
        landingFP
        ;
        Lokasi == go,
        nl , write('Masuk go'), nl, nl,
        landingGO
    ).

/*Properti*/
landingPropertiLawan:-
    1 = 1.
landingPropertiSendiri:-
    1 = 1.
landingPropertiKosong:-
    nl , write('Mau beli?'), nl, nl,
    write('Aksi: '),
    read(Input),

    (
        Input == help,
        write('beli_(X).: beli properti'), nl,
        write('    X dapat berisi tanah, bangunan1, bangunan2, bangunan3, atau landmark'), nl,
        write('    bangunan3 dapat dibeli setelah satu putaran'), nl,
        write('    landmark dapat dibeli setelah dua putaran'), nl,
        write('tidak.: tidak membeli properti'), nl,
        landingPropertiKosong
        ;
        Input == beli_tanah,
        write('tanah dibeli'), nl
        ;
        Input == beli_bangunan1,
        write('bangunan1 dibeli'), nl
        ;
        Input == beli_bangunan2,
        write('bangunan2 dibeli'), nl
        ;
        Input == beli_bangunan3,
        (
            lewatGO(Pemain, KaliLewat),
            KaliLewat > 0,
            write('bangunan3 dibeli'), nl
            ;
            write('bangunan3 belum bisa dibeli'), nl,
            landingPropertiKosong
        )
        ;
        Input == beli_landmark,
        (
            lewatGO(Pemain, KaliLewat2),
            KaliLewat2 > 1,
            write('landmark dibeli'), nl
            ;
            write('landmark belum bisa dibeli'), nl,
            landingPropertiKosong
        )
        ;
        Input == tidak,
        write('Properti tidak dibeli'), nl
        ;
        write('Input tidak valid'), nl,
        landingPropertiKosong
    ).

landingProperti(Pemain):-
    lokasiPemain(Pemain, Lokasi),
    (
        \+ asetProperti(Siapapun, Lokasi),
        nl , write('Properti kosong'), nl, nl,
        landingPropertiKosong
        ;
        asetProperti(Pemain, Lokasi),
        nl , write('Properti milik sendiri'), nl, nl,
        landingPropertiLawan
        ;
        asetProperti(Pemainlain, Lokasi),
        Pemainlain \= Pemain,
        nl , write('Properti milik orang lain'), nl, nl,
        landingPropertiSendiri
    ).

checkLokasi(Pemain):-
    lokasiPemain(Pemain, Lokasi),
    
    (
        properti(Lokasi),
        nl , write('Properti'), nl, nl,
        landingProperti(Pemain)
        ;
        nl, write('Bukan Properti'), nl, nl,
        landingNonProperti(Pemain)
    ).


/*Move*/
inMove(Pemain, X, []):-
    /*rekursif untuk list supaya sirkuler*/
    addBalance(Pemain, 200),

    lewatGO(Pemain, KaliLewat),
    KaliLewatBaru is KaliLewat + 1,

    retract(lewatGO(Pemain, _)),
    asserta(lewatGO(Pemain, KaliLewatBaru)),
    
    listLokasi(ListLokasi),
    inMove(Pemain, X, ListLokasi).
inMove(Pemain, 1, [H|_T]):-
    /*rekursif untuk basis jika nilai integernya 1*/
    changeLokasiPemain(Pemain, H),
    checkLokasi(Pemain).
    
inMove(Pemain, X, [_H|T]):-
    /*rekursif untuk basis jika nilai integernya bukan 1*/
    A is X-1,
    inMove(Pemain, A, T).
move(Pemain, X):-
    /*ganti lokasi dari nilai integer*/
    listLokasi(ListLokasi),
    lokasiPemain(Pemain, Lokasi),
    inNextLocations(Pemain, Lokasi, ListLokasi, Output),
    inMove(Pemain, X, Output).

/*properti----------------------------------------------*/
addPosession(Pemain, Properti, Level):-
    /*nambahin posession di paling depan*/
    posessionArr(Pemain, OldArr),
    retract(posessionArr(Pemain, _X)),

    asserta(asetProperti(Pemain, Properti)),
    asserta(tingkatanAset(Properti, Level)),
    
    asserta(posessionArr(Pemain, [Properti|OldArr])).

inRemovePosession(Pemain, Properti, [Properti|T], T).
    /*rekursif buat basis ngeluarin properti dari posession*/
inRemovePosession(Pemain, Properti, [H|T], [H|Next]):-
    /*rekursif buat ngeluarin properti dari posession*/
    inRemovePosession(Pemain, Properti, T, Next).

removePosession(Pemain, Properti):-
    /*ngeluarin properti dari posession*/
    posessionArr(Pemain, OldArr),
    inRemovePosession(Pemain, Properti, OldArr, NewArr),
    
    retract(asetProperti(Pemain, Properti)),
    retract(tingkatanAset(Properti, _X)),

    retract(posessionArr(Pemain, _Arr)),
    asserta(posessionArr(Pemain, [Properti|NewArr])).

sellProperti(Pemain, Properti):-
    /*ngejual properti dari posession dengan harga 80%*/
    biayaProperti(Properti, Biaya),
    HargaJual is Biaya*80/100,
    addBalance(Pemain, HargaJual),
    removePosession(Pemain, Properti),!.

inJumlahAsset(Pemain, X, []):-
    /*rekursif untuk ngitung jumlah asset*/
    X is 0.
inJumlahAsset(Pemain, X, [H|T]):-
    /*rekursif untuk ngitung jumlah asset*/
    biayaProperti(H, Biaya),
    inJumlahAsset(Pemain, A, T),
    X is Biaya + A,!.
jumlahAsset(Pemain, Output):-
    /*ngitung jumlah asset*/
    posessionArr(Pemain, PossArr),
    inJumlahAsset(Pemain, Output, PossArr).


/*Bangkrut---------------------------------------------*/
checkBangkrut(Pemain):-
    /*bangkrut kalo duit < 0*/
    /*ini sintaks if else*/
    balance(Pemain, X),
    (X < 0,

        /*ini harusnya condition semua harga jual - balance < 0 tapi belum*/

        write('Yah kalah :( \n'),
        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true))
    ;X < 0,
        write('Duit habis bos\n'),
        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true)),
        resolveBangkrut(Pemain)
    ;X >= 0).

resolveBangkrut(Pemain):-
    /*buat resolve kalo ada yang bangkrut*/
    /*harusnya fitur jual properti di sini tapi belum*/
    write('Bayar utang bos\n'),
    write('Properti yang akan dijual: \n'),
    retract(bangkrut(Pemain, _X)),
    asserta(bangkrut(Pemain, false)),

    /*Masukin jual properti ke sini*/    
    /*sellProperti(Pemain, Properti)*/    

    checkBangkrut(Pemain),
    !.



    

