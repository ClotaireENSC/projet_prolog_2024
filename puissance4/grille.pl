:- module(grille, [replace_at_index/4, grilleInit/1, showGrid/1, printGrid/1, printColumns/2, transpose/2, update_grille/4]).

% Initialisation de la grille
grilleInit(Liste) :-
    Liste = [[*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *],
             [*, *, *, *, *, *]].

% Fonction pour afficher la grille pour lutilisateur
showGrid(Grid) :-
    write('Grille de Puissance 4:'), nl,
    write(' 1 2 3 4 5 6 '), nl,
    printGrid(Grid).

printGrid([]).
printGrid([Row|Rest]) :-
    write(Row), nl,
    printGrid(Rest).

printColumns([], _).
printColumns([Head|Queue], Index) :-
    write(Index), write(' '), write(Head), nl,
    NewIndex is Index + 1,
    printColumns(Queue, NewIndex).

% Transposer la grille
transpose([], []).
transpose([[]|_], []) :- !.
transpose(Matrix, [Row|Rest]) :-
    maplist(nth1(1), Matrix, Row),
    maplist(remove_first, Matrix, NewMatrix),
    transpose(NewMatrix, Rest).

remove_first([_|Tail], Tail).

% Remplacer une valeur à un certain index
replace_at_index(Index, [Head|Tail], NewValue, [Head|NewTail]) :-
    Index > 1,
    NextIndex is Index - 1,
    replace_at_index(NextIndex, Tail, NewValue, NewTail).
replace_at_index(1, [_|Tail], NewValue, [NewValue|Tail]).

% Mettre à jour la grille avec la nouvelle colonne
update_grille(Grille, Position, NewColumn, NewGrille) :-
    transpose(Grille, Transposed),
    replace_at_index(Position, Transposed, NewColumn, NewTransposed),
    transpose(NewTransposed, NewGrille).
