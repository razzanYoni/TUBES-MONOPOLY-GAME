
%:- [player, lokasinProperti].

% Rules

/* cek posisi player apakah di tiles tax */
isOnTax(Player) :- lokasiPemain(Player, X), (X == tx1 ; X == tx2).


/* Menghasilkan tax yang harus dibayar */

taxValue(Player, Tax) :- totalAsset(Player, Total), Tax is Total / 10.

/* Mengurangi Saldo Player dengan Tax */

bayarPajak(Player) :-   isOnTax(Player), taxValue(Player, Tax),
                        nl, nl,
                        write('    Anda harus membayar pajak sebesar '), 
                        write(Tax),
                        write(' dolar.')
                        subtBalance(Player, Tax).