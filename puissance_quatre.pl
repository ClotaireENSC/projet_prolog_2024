% transposer la grille
transpose([], []).
transpose([[]|_], []) :- !.
transpose(Matrix, [Row|Rest]) :-
    maplist(nth1(1), Matrix, Row),
    maplist(remove_first, Matrix, NewMatrix),
    transpose(NewMatrix, Rest).


remove_first([_|Tail], Tail).

% Initialize 
grilleInit(Liste) :-
    Liste = [[*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *]].

showGrid(Grid) :-
    write('Grille de Puissance 4:'), nl,
    write(' 1 2 3 4 5 6 '),nl,
    printGrid(Grid).

printGrid([]).
printGrid([Row|Rest]) :-
    write(Row), nl,
    printGrid(Rest).

printColumns([], _).
printColumns([Head|Queue], Index) :-
    
    write(Index),write(' '), write(Head), nl,
    NewIndex is Index + 1,
    printColumns(Queue, NewIndex).






% remplacer une valeur a un certain index
replace_at_index(Index, [Head|Tail], NewValue, [Head|NewTail]) :-
    Index > 1,
    NextIndex is Index - 1,
    replace_at_index(NextIndex, Tail, NewValue, NewTail). 
replace_at_index(1, [_|Tail], NewValue, [NewValue|Tail]).


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




% Verifier à quel  index doit etre mis le pion 
% Cas de base, l element est  à la base de la liste 
check_position([Head|_],Index,1) :-
    Head \='*', !.
check_position([_|Tail],Index,CurrentIndex):-
    NextIndex is CurrentIndex+1,
    check_position(Tail,Index,NextIndex).

% si la liste est vide ou na pas encore etee modifiee
check_position([],-1,_):-
    !.















% Test entry point


start :-
    grilleInit(Liste),
    showGrid(Liste).






    





