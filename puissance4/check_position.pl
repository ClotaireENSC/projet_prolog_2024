:- module(check_position, [check_position/3, get_column/3]).

check_position([Head|_], Index, CurrentIndex) :-
    Head \= '*', !,
    Index = -1.
check_position([Head|_], Index, CurrentIndex) :-
    Head = '*',
    CurrentIndex = 6, !,
    Index = CurrentIndex.
check_position([Head|_], Index, CurrentIndex) :-
    Head = '*',
    Index = CurrentIndex-1.
check_position([Head|_], Index, CurrentIndex) :-
    Head = '*', !,
    Index is CurrentIndex - 1.
check_position([_|Tail], Index, CurrentIndex) :-
    NextIndex is CurrentIndex + 1,
    check_position(Tail, Index, NextIndex).

% Si la liste est vide ou n a pas encore été modifiée
check_position([], Index, CurrentIndex) :-
    Index = -1.
% Fonction pour récupérer une colonne spécifique de la grille
get_column([], _, []).
get_column([Row|Rest], Index, [ColElement|ColRest]) :-
    nth1(Index, Row, ColElement),
    get_column(Rest, Index, ColRest).
