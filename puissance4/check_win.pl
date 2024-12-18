:- module(check_win, [diagonale_montante/4,diagonale_descendante/4,diagonale_descendante_gagnant/4,sublist/3,sublist_helper/4,diagonale_montante_gagnant/4,horizontal_gagnant/4,vertical_gagnant/4]).

% VERIFIER SI LE JOUEUR A GAGNER EN ALLANT VOIR 

% Vérifier si une sous-liste de 4 éléments consécutifs est égale au joueur
sublist(List, Index, Player) :-
    sublist_helper(List, Index, Player, 4).

sublist_helper([Player, Player, Player, Player | _], _, Player, 4).
sublist_helper([_ | Tail], Index, Player, Count) :-
    NewCount is Count - 1,
    sublist_helper(Tail, Index, Player, NewCount).

horizontal_gagnant(Grid, X, Y, Player) :-
    nth1(X, Grid, Row),
    sublist(Row, Y, Player).

% Vérifier une colonne verticale
vertical_gagnant(Grid, X, Y, Player) :-
    transpose(Grid, Transposed),
    nth1(Y, Transposed, Column),
    sublist(Column, X, Player).

% Vérifier une diagonale montante
diagonale_montante_gagnant(Grid, X, Y, Player) :-
    diagonale_montante(Grid, X, Y, Player).

% Vérifier une diagonale descendante
diagonale_descendante_gagnant(Grid, X, Y, Player) :-
    diagonale_descendante(Grid, X, Y, Player).

% Vérifier une diagonale descendante (haut à gauche -> bas à droite)
diagonale_descendante(Grid, X, Y, Player) :-
    X =< 3, Y =< 4,  % Vérifie que les indices permettent une diagonale de 4 éléments
    nth1(X, Grid, Row1),
    nth1(Y, Row1, Player), % Vérifier la première case
    X1 is X + 1, Y1 is Y + 1,
    nth1(X1, Grid, Row2), nth1(Y1, Row2, Player), % Vérifier la deuxième case
    X2 is X + 2, Y2 is Y + 2,
    nth1(X2, Grid, Row3), nth1(Y2, Row3, Player), % Vérifier la troisième case
    X3 is X + 3, Y3 is Y + 3,
    nth1(X3, Grid, Row4), nth1(Y3, Row4, Player). % Vérifier la quatrième case

% Vérifier une diagonale montante (bas à gauche -> haut à droite)
diagonale_montante(Grid, X, Y, Player) :-
    X >= 4, Y =< 4,  % Vérifie que les indices permettent une diagonale de 4 éléments
    nth1(X, Grid, Row1),
    nth1(Y, Row1, Player), % Vérifier la première case
    X1 is X - 1, Y1 is Y + 1,
    nth1(X1, Grid, Row2), nth1(Y1, Row2, Player), % Vérifier la deuxième case
    X2 is X - 2, Y2 is Y + 2,
    nth1(X2, Grid, Row3), nth1(Y2, Row3, Player), % Vérifier la troisième case
    X3 is X - 3, Y3 is Y + 3,
    nth1(X3, Grid, Row4), nth1(Y3, Row4, Player). % Vérifier la quatrième case
