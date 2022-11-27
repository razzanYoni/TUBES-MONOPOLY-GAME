/*DEPENDENCY KE lokasinproperti.pl*/


/*
TODO
-Tambahin angel card waktu move
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
lokasiPemain(p1, tx1).
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
asetProperti(p1, d1).
asetProperti(p1, a2).
asetProperti(p1, a1).
asetProperti(p2, g1).
asetProperti(p2, b2).
asetProperti(p2, b3).

tingkatanAset(d1, 'Tanah').
tingkatanAset(a2, 'Tanah').
tingkatanAset(a1, 'Tanah').
tingkatanAset(h3, 'Bangunan 1').
tingkatanAset(b1, 'Landmark').
tingkatanAset(b2, 'Tanah').
tingkatanAset(b3, 'Tanah').
tingkatanAset(d1, 'Bangunan 2').
posessionArr(p1, [d1,a2,a1]).
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

changePlayerDirect(X):-
    /*ganti player secara direct*/
    retract(currentPemain(_)),
    asserta(currentPemain(X)).

switchPlayer:-
    /*ganti player selang seling*/
    currentPemain(X),
    X == p1,
    retract(currentPemain(_)),
    asserta(currentPemain(p2)).
switchPlayer:-
    /*ganti player selang seling*/
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
        Pilihan == 1, subtBalance(Pemain,50), playGameCenter
        ;
        Pilihan == 2 
    ),
    write('===Terima Kasih Telah Berkunjung ke Game Center===').



landingNonProperti(Pemain):-
    /*detektor mendarat player di non properti*/
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

/*Properti
landingPropertiLawan:-
    biayaSewaProperti(Lokasi, BiayaSewa),
    subtBalance(Pemain, biayaSewa),
    balance(Pemain, Uang), 
    (Uang >= 0, write('Ambil Alih?(ya/tidak) '), read(AmbilAlih),
        (
            AmbilAlih == ya, 
                (
                    har
                )
            ;
            Ambil == tidak
        )
    ; 
    ), */



landingPropertiSendiri:-
    1 = 1.
landingPropertiKosong:-
    /*aksi jika player mendarat di properti kosong*/
    printMap,
    write('Sekarang giliran: '), currentPemain(X), write(X), nl,
    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,

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
        Input == tidak,
        write('Properti tidak dibeli'), nl
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
                    idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan1,
                hargaProperti(LokasiBeli,_, HargaBeli,_,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan1 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan2,
                hargaProperti(LokasiBeli,_, _, HargaBeli,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == bangunan3,
                hargaProperti(LokasiBeli,_, _,_, HargaBeli,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan3 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli)
                )
                ;
                InputPilihan == landmark,
                hargaProperti(LokasiBeli,_, _, _,_, HargaBeli),
                (
                    lewatGO(Pemain, KaliLewat2),
                    KaliLewat2 > 1,(
                        Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                        ;
                        write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                        subtBalance(Pemain, HargaBeli)
                    )
                    ;
                    write('landmark belum bisa dibeli'), nl,
                    landingPropertiKosong,fail
                )
                ;
                InputPilihan == cancel
                ;
                write('Input tidak valid'), nl, fail
            )    
        )
        ;
        Input \= help,
        write('Input tidak valid'), nl,
        landingPropertiKosong
    ).

landingProperti(Pemain):-
    /*detektor mendarat player di properti*/
    lokasiPemain(Pemain, Lokasi),
    (
        \+ asetProperti(_Siapapun, Lokasi),
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
    /*detektor mendarat player di properti atau non*/
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
    changeLokasiPemain(Pemain, H),!.
    
inMove(Pemain, X, [_H|T]):-
    /*rekursif untuk basis jika nilai integernya bukan 1*/
    A is X-1,
    inMove(Pemain, A, T).
move(Pemain, X):-
    /*ganti lokasi dari nilai integer*/
    listLokasi(ListLokasi),
    lokasiPemain(Pemain, Lokasi),
    inNextLocations(Pemain, Lokasi, ListLokasi, Output),
    inMove(Pemain, X, Output),!.

/*properti----------------------------------------------*/
addPosession(Pemain, Properti, Level):-
    /*nambahin posession di paling depan*/
    \+ asetProperti(Pemain, Properti),
    properti(Properti),
    posessionArr(Pemain, OldArr),
    retract(posessionArr(Pemain, _X)),

    asserta(asetProperti(Pemain, Properti)),
    asserta(tingkatanAset(Properti, Level)),
    
    asserta(posessionArr(Pemain, [Properti|OldArr])).

addPosession(Pemain, Properti, Level):-
    write('Properti tidak valid'), nl.

inRemovePosession(_Pemain, Properti, [Properti|T], T).
    /*rekursif buat basis ngeluarin properti dari posession*/
inRemovePosession(Pemain, Properti, [H|T], [H|Next]):-
    /*rekursif buat ngeluarin properti dari posession*/
    inRemovePosession(Pemain, Properti, T, Next).

removePosession(Pemain, Properti):-
    /*ngeluarin properti dari posession*/
    asetProperti(Pemain, Properti),
    posessionArr(Pemain, OldArr),
    inRemovePosession(Pemain, Properti, OldArr, NewArr),
    
    retract(asetProperti(Pemain, Properti)),
    retract(tingkatanAset(Properti, _X)),

    retract(posessionArr(Pemain, _Arr)),
    asserta(posessionArr(Pemain, NewArr)).

removePosession(Pemain, Properti):-
    write('Properti tidak valid'), nl.


sellProperti(Pemain, Properti):-
    /*ngejual properti dari posession dengan harga 80%*/
    asetProperti(Pemain, Properti),
    biayaProperti(Properti, Biaya),
    HargaJual is Biaya*80/100,
    addBalance(Pemain, HargaJual),
    removePosession(Pemain, Properti),!.

sellProperti(Pemain, Properti):-
    /*kalo properti tidak dimiliki*/
    write('Properti tidak valid'), nl.


inJumlahAsset(_Pemain, 0, []).
inJumlahAsset(Pemain, X, [H|T]):-
    /*rekursif untuk ngitung jumlah asset*/
    nilaiProperti(H, Nilai),
    inJumlahAsset(Pemain, A, T),
    X is Nilai + A,!.
jumlahAsset(Pemain, Output):-
    /*ngitung jumlah asset*/
    posessionArr(Pemain, PossArr),
    inJumlahAsset(Pemain, Output, PossArr).
totalAsset(Pemain, Output):-
    /*ngitung asset + balance*/
    jumlahAsset(Pemain, Asset),
    balance(Pemain, Uang),
    Output is Asset + Uang.

inShowProperties(_Pemain, _X, []).
inShowProperties(Pemain, X, [H|T]):-
    /*rekursif show properties*/
    tingkatanAset(H, Tingkat),
    write(X), write('. '), write(H), write(' - '), write(Tingkat),nl,
    A is X + 1,
    inShowProperties(Pemain, A, T).
showProperties(Pemain):-
    /*print properti yang dimiliki player dalam bentuk daftar*/
    posessionArr(Pemain, PossArr),
    inShowProperties(Pemain, 1, PossArr),!.

checkPlayerDetail(Pemain):-
    /*print informasi player*/
    pemain(Pemain),
    lokasiPemain(Pemain, Lokasi),
    balance(Pemain, Uang),
    jumlahAsset(Pemain, Asset),
    totalAsset(Pemain, Total),

    nl, write('Informasi '), write(Pemain), nl, nl,

    write('Lokasi                        : ' ), write(Lokasi), nl,
    write('Total Uang                    : ' ), write(Uang), nl,
    write('Total Nilai Properti          : ' ), write(Asset),nl,
    write('Total Aset                    : '), write(Total),nl,nl,

    write('Daftar Kepemilikan Properti   : ' ),nl,
    showProperties(Pemain),

    write('Daftar Kepemilikan Card       : '),nl.

    /*Masuk ke sini yang card*/

playerDetail(_Pemain):-
    write("Nama pemain tidak valid").



/*Bangkrut---------------------------------------------*/
checkBangkrut(Pemain):-
    /*bangkrut kalo duit < 0*/
    /*kalo asset masih bisa dijual bakal masuk resolve bangkrut*/
    balance(Pemain, X),
    (X < 0,

        jumlahAsset(Pemain, AssetValue),
        (AssetValue * 80/100) + X < 0,

        nl,
        write('Pemain '), write(Pemain), write(' telah bangkrut'), nl,

        pemain(Pemainlain),
        Pemainlain \= Pemain,

        write('Pemenangnya adalah '), write(Pemainlain),nl,nl,
        write('Permainan telah berakhir, terima kasih telah bermain monopoli boku no prolog'),nl,

        write('panggil \'resetGame.\' untuk mereset kembali ke kondisi semula'),nl,

        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true)),!
    ;X < 0,
        (AssetValue * 80/100) + X >= 0,
        nl,
        write('Uangmu tidak mencukupi untuk membayar, kamu harus memilih properti untuk dijual'),nl,
        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true)),
        resolveBangkrut(Pemain)
    ;X >= 0).

resolveBangkrut(Pemain):-
    /*buat resolve kalo ada yang bangkrut*/
    balance(Pemain, Utang),nl,
    write('Utangmu senilai '), write(Utang), nl,
    write('properti yang kamu miliki adalah sebagai berikut'), nl,
    showProperties(Pemain),

    write('Properti yang akan dijual: '),
    read(InputProperty),
    sellProperti(Pemain, InputProperty),

    retract(bangkrut(Pemain, _X)),
    asserta(bangkrut(Pemain, false)),

    checkBangkrut(Pemain),
    !.

resetGame:-
    /*buat retract semua fakta jadi kaya pas awal mulai*/
    retractall(bangkrut(_A, _B)),
    retractall(lokasiPemain(_C, _D)),
    retractall(bangkrut(_E, _F)),
    retractall(currentPemain(_G)),
    retractall(balance(_H, _I)),
    retractall(asetProperti(_K, _L)),
    retractall(tingkatanAset(_M, _N)),
    retractall(posessionArr(_O, _P)),
    retractall(lewatGO(_Q, _R)),

    asserta(currentPemain(p1)),
    asserta(lokasiPemain(p1, go)),
    asserta(lokasiPemain(p2, go)),
    asserta(balance(p1, 300)),
    asserta(balance(p2, 300)),
    asserta(bangkrut(p1, false)),
    asserta(bangkrut(p2, false)),
    asserta(lewatGO(p1, 0)),
    asserta(lewatGO(p1, 0)).