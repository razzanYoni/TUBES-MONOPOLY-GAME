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
tingkatanAset(c2, 'Bangunan 1').
tingkatanAset(a3, 'Landmark').
tingkatanAset(g1, 'Tanah').
tingkatanAset(b2, 'Tanah').
tingkatanAset(b3, 'Tanah').
tingkatanAset(d1, 'Bangunan 2').
posessionArr(p1, [d1,a2,a3]).
posessionArr(p2, [g1,b2,b3]).

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
landingGC:-
    write('Apakah kamu ingin menguji keberuntunganmu??? (Masukkan angka: )'),
    write('1. Ya'), nl,
    write('2. Tidak'), nl,
    write('Pilihan: '), read(Pilihan),
    (
        Pilihan == 1, subtBalance(Pemain,50), playGameCenter,
        ;
        Pilihan == 2 
    ).
    write('===Terima Kasih Telah Berkunjung ke Game Center===').



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
        landingTX
        ;
        Lokasi == wt,
        nl , write('Masuk world tour'), nl, nl,
        landingWT
        ;
        lokasi == gc,
        nl, write('====SELAMAT DATANG DI GAME CENTER==='), nl, nl,
        landingGC
    ).

/*Properti*/
landingPropertiLawan:-
    subtBalance(Pemain, hargas)
landingPropertiSendiri:-
    1 = 1.
landingPropertiKosong:-
    printMap,

    currentPemain(Player),
    balance(Player, Uang),
    nl , write('Mau beli?'), nl, nl,
    write('Aksi: '),
    read(Input),

    (
        Input == help,
        nl, write('Perintah yang tersedia'), nl,
        write('beli.: beli properti'), nl,
        write('    bangunan3 dapat dibeli setelah satu putaran'), nl,
        write('    landmark dapat dibeli setelah dua putaran'), nl,
        write('tidak.: tidak membeli properti'), nl,
        landingPropertiKosong
        ;
        Input == beli,
        (repeat, 
            lokasiPemain(Pemain, LokasiBeli),
            checkPropertyDetail(LokasiBeli),

            nl, write('Uang Anda: '), write(Uang), nl,
            write('Properti yang mau dibeli: '),
        
            read(InputPilihan),
            (
                InputPilihan == help,
                nl, write('Perintah yang tersedia'), nl,
                write('tanah.: beli Tanah'), nl,
                write('bangunan1.: beli Bangunan1'), nl,
                write('bangunan2.: beli Bangunan2'), nl,
                write('bangunan3.: beli Bangunan3'), nl,
                write('landmark.: beli Landmark'), nl,
                write('cancel.: tidak jadi membeli properti'), nl, fail
                ;
                InputPilihan == tanah,
                hargaProperti(LokasiBeli, HargaBeli, _,_,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Tanah berhasil dibeli! '), nl, 
                    idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu') nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan1,
                hargaProperti(LokasiBeli,_, HargaBeli,_,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan1 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu') nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan2,
                hargaProperti(LokasiBeli,_, _, HargaBeli,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu') nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan3,
                hargaProperti(LokasiBeli,_, _,_, HargaBeli,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan3 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu') nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == landmark,
                (lewatGO(Pemain, KaliLewat2),
                    KaliLewat2 > 1,
                hargaProperti(LokasiBeli,_, _, _,_, HargaBeli),
                (
                    lewatGO(Pemain, KaliLewat2),
                    KaliLewat2 > 1,(
                        Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                        ;
                        write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu') nl,
                        subtBalance(Pemain, HargaBeli)
                    )
                );
                write('landmark belum bisa dibeli'), nl,
                landingPropertiKosong,fail
                ;
                InputPilihan == cancel
                ;
                write('Input tidak valid'), nl, fail
            )    
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
        landingPropertiSendiri
        ;
        asetProperti(Pemainlain, Lokasi),
        Pemainlain \= Pemain,
        nl , write('Properti milik orang lain'), nl, nl,
        landingPropertiLawan
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
    asserta(bangkrut(Pemain, false)),

    /*Masukin jual properti ke sini*/    
    /*sellProperti(Pemain, Properti)*/    

    checkBangkrut(Pemain),
    !.



    

