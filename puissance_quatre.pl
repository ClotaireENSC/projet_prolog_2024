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
    transpose(Grid, Transposed),
    write('Grille de Puissance 4:'), nl,
    write('   1 2 3 4 5 6 7'),nl,
    printColumns(Transposed, 1).
% Print columns
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






    





