
:- [player, lokasinProperti].

% Rules

/* cek posisi player apakah di tiles tax */
isOnTax(Player) :- lokasiPemain(Player, X), (X == tx1 ; X == tx2).

indeksJenis(Jenis) :- Jenis == 


/* Menghasilkan nilai properti dalam tiles */

ProValue(Tile, V) :- hargaProperti([H|T]), Tile == H , TingkatanAset(Tile, Jenis), 