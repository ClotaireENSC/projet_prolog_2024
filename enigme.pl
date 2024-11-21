% Devant est le danger, le salut est derrière.
% Deux sauront parmi nous conduire à la lumière,
% L’une d’entre les sept en avant te protège,
% Et une autre en arrière abolira le piège,
% Deux ne pourront t’offrir que simple vin d’ortie,
% Trois sont mortels poisons, promesse d’agonie,
% Choisis, si tu veux fuir un éternel supplice,
% Pour t’aider dans ce choix, tu auras quatre indices.

% Le premier : si rusée que soit leur perfidie,
% Les poisons sont à gauche des deux vins d’ortie,

% Le second : différente à chaque extrémité,
% Si tu vas de l’avant, nulle n’est ton alliée.

% Le troisième : elles sont de tailles inégales,
% Ni naine ni géante en son sein n’est fatale.

% Quatre enfin : les deuxièmes, à gauche comme à droite,
% Sont jumelles de goût, mais d’aspect disparates.

% Indice ajouté (5) : La naine est plus a gauche que la géante

% Indice implicite (0) : toutes les potions sont uniques

% P FN P P VO FV VO

% P : poison
% FN : flammes noires
% VO : vin d^orties
% FV : flammes violettes

% Résolution de l^énigme des potions

% Définition des types possibles de potions
potion(flamme_noire).
potion(flamme_violette).
potion(poison1).
potion(poison2).
potion(poison3).
potion(vin_ortie1).
potion(vin_ortie2).

vin(X):- X = vin_ortie1; X = vin_ortie2.
poison(X):- X = poison1; X = poison2; X = poison3.
flamme(X):- X = flamme_noire; X = flamme_violette.

disposition([P1,P2,P3,P4,P5,P6,P7]):-
    indice0([P1,P2,P3,P4,P5,P6,P7]),
    indice1([P1,P2,P3,P4,P5,P6,P7]),
    indice2([P1,P2,P3,P4,P5,P6,P7]),
%    indice3([P1,P2,P3,P4,P5,P6,P7]),
    indice4([P1,P2,P3,P4,P5,P6,P7]).
%    indice5([P1,P2,P3,P4,P5,P6,P7])

meme_gout(X,Y):- (vin(X), vin(Y)); (poison(X), poison(Y)); (flamme(X), flamme(Y)).

pas_de_poison_dans([]).
pas_de_poison_dans([P|Q]):- \+ poison(P), pas_de_poison_dans(Q).

indice0(L):- permutation([flamme_noire, flamme_violette, poison1, vin_ortie1, vin_ortie2, poison2, poison3],L).

indice1([]).
indice1([P|Q]):- potion(P), ((vin(P), pas_de_poison_dans(Q), indice1(Q)); (\+ vin(P), indice1(Q))).

indice2([P1,_,_,_,_,_,P7]):- potion(P1), potion(P7), P1 \== P7, P1 \== flamme_violette, P7 \== flamme_violette.

indice4([_,P2,_,_,_,P6,_]):- potion(P2), potion(P6), P2\== P6, meme_gout(P2,P6).