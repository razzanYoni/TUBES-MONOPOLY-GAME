/*
TODO
-Samain variabel & fungsi sama properti
-Tambahin angel card waktu move
-Tambahin move (Done?)
*/
:-include('lokasinProperti.pl').

/*DATA Pemain*/

/*Current pemain*/
:-dynamic(currentPemain1/1).
currentPemain1(p1).
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


/*TEMP*/
asetProperti(p1, a1).
asetProperti(p1, a2).
asetProperti(p1, a3).
asetProperti(p2, b1).
asetProperti(p2, b2).
asetProperti(p2, b3).
tingkatanAset(a1, 'Tanah').
tingkatanAset(c2, 'Bangunan 1').
tingkatanAset(a3, 'Landmark').
tingkatanAset(g1, 'Tanah').
tingkatanAset(b2, 'Tanah').
tingkatanAset(b3, 'Tanah').
posessionArr(p1, [a1,a2,a3]).
posessionArr(p2, [g1,b2,b3]).
listLokasi([go,a1,a2,a3,b1,b2,b3]).
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

inMove(Pemain, X, []):-
    /*rekursif untuk list supaya sirkuler*/
    listLokasi(ListLokasi),
    inMove(Pemain, X, ListLokasi).
inMove(Pemain, 1, [H|_T]):-
    /*rekursif untuk basis jika nilai integernya 1*/
    changeLokasiPemain(Pemain, H).
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
    asserta(bangkrut(Pemain, nope)),

    /*Masukin jual properti ke sini*/    
    /*sellProperti(Pemain, Properti)*/    

    checkBangkrut(Pemain),
    !.



    

