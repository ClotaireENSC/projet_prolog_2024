%%%%%%%%%%%%
%% GRILLE %%
%%%%%%%%%%%%

initial_grid([ [e, e, e, e, e, e, e],
               [e, e, e, e, e, e, e],
               [e, e, e, e, e, e, e],
               [e, e, e, e, e, e, e],
               [e, e, e, e, e, e, e],
               [e, e, e, e, e, e, e] ]).

print_grid([]).
print_grid([P|Q]) :-
    print_grid(Q),
    nl,
    print_row(P).

print_row([]).
print_row([e|T]) :-
    write('. '),
    print_row(T).
print_row([x|T]) :-
    write('X '),
    print_row(T).
print_row([o|T]) :-
    write('O '),
    print_row(T).


%%%%%%%%%%%%%%%%
%% MOUVEMENTS %%
%%%%%%%%%%%%%%%%

play_move(Grid, Col, Player, NewGrid) :-
    Col > 0, Col < 8, 
    play_move_in_column(Grid, Col, Player, NewGrid).

play_move_in_column([P|Q], Col, Player, [NewP|Q]) :-
    nth1(Col, P, e),
    replace(P, Col, Player, NewP).

play_move_in_column([Row|_], Col, _, _) :-
    \+ nth1(Col, Row, e),
    fail.

play_move_in_column([P|Q], Col, Player, [P|NewQ]) :-
    play_move_in_column(Q, Col, Player, NewQ).

replace([_|T], 1, X, [X|T]).
replace([H|T], N, X, [H|R]) :-
    N > 1,
    N1 is N - 1,
    replace(T, N1, X, R).

%%%%%%%%%%%%%%%%%%
%% MOUVEMENT IA %%
%%%%%%%%%%%%%%%%%%

coup_gagnant(Grid, Player, Coups) :-
    findall(Col, (between(1, 7, Col),
                  play_move(Grid, Col, Player, NewGrid),
                  check_victory(NewGrid, x)),
            Coups).   

ai_move(Grid, NewGrid) :-
    coup_gagnant(Grid, o, CoupsGagnantsO),
    (        
        CoupsGagnantsO \= [] ->
        random_member(Col, CoupsGagnantsO),
        play_move(Grid, Col, o, NewGrid)
    );
    coup_gagnant(Grid, x, CoupsGagnantsX),
    (
        CoupsGagnantsX \= [] ->
        random_member(Col, CoupsGagnantsX),
        play_move(Grid, Col, o, NewGrid);
        random_between(1, 7, Col),
        play_move(Grid, Col, o, NewGrid);
        ai_move(Grid, NewGrid)
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DETECTION DE VICTOIRE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_victory(Grid, Player) :-
    (   horizontal_victory(Grid, Player)
    ;   vertical_victory(Grid, Player)
    ;   diagonal_victory(Grid, Player)
    ).

horizontal_victory(Grid, Player) :-
    member(Row, Grid),
    four_in_a_row(Row, Player).

vertical_victory(Grid, Player) :-
    transpose(Grid, Transposed),
    member(Row, Transposed),
    four_in_a_row(Row, Player).

diagonal_victory(Grid, Player) :-
    diagonals(Grid, Diagonals),
    member(Diagonal, Diagonals),
    four_in_a_row(Diagonal, Player).

four_in_a_row([Player, Player, Player, Player|_], Player).
four_in_a_row([_, H|T], Player) :-
    four_in_a_row([H|T], Player).

diagonals(Grid, Diagonals) :-
    find_diagonals(Grid, Diagonals).

find_diagonals(Grid, Diagonals) :-
    findall(Diagonal, (between(0, 3, ColIndex), extract_diagonal(Grid, 0, ColIndex, Diagonal)), Diagonals1),
    transpose(Grid, TransposedGrid),
    findall(Diagonal, (between(1, 2, ColIndex), extract_diagonal(TransposedGrid, 0, ColIndex, Diagonal)), Diagonals2),
    append(Diagonals1, Diagonals2, Diagonals11),

    reverse_matrix_by_columns(Grid,RevGrid),

    findall(Diagonal, (between(0, 3, ColIndex), extract_diagonal(RevGrid, 0, ColIndex, Diagonal)), Diagonals3),
    transpose(RevGrid, TransposedRevGrid),
    findall(Diagonal, (between(1, 2, ColIndex), extract_diagonal(TransposedRevGrid, 0, ColIndex, Diagonal)), Diagonals4),
    append(Diagonals3, Diagonals4, Diagonals12),

    append(Diagonals11,Diagonals12, Diagonals).

extract_diagonal([], _, _, []).
extract_diagonal([Row|Rest], RowIndex, ColIndex, [Elem|RestDiag]) :-
    (   nth0(ColIndex, Row, Elem)
    ->  NextRowIndex is RowIndex + 1,
        NextColIndex is ColIndex + 1,
        extract_diagonal(Rest, NextRowIndex, NextColIndex, RestDiag)
    ;   RestDiag = []
    ).

reverse_matrix_by_columns([], []).
reverse_matrix_by_columns([Row|Rest], [ReversedRow|RestReversed]) :-
    reverse(Row, ReversedRow),    % Inverse chaque ligne
    reverse_matrix_by_columns(Rest, RestReversed).

transpose([[]|_], []).
transpose(Matrix, [Row|Rest]) :-
    maplist(head_tail, Matrix, Row, Tails),
    transpose(Tails, Rest).

head_tail([H|T], H, T).

%%%%%%%%%%%%%
%% EGALITE %%
%%%%%%%%%%%%%

egalite(Grid) :-
    \+ (member(Row, Grid), member(e, Row)),
    \+ check_victory(Grid, x),
    \+ check_victory(Grid, o).

%%%%%%%%%%%%%%%%%%%
%% BOUCLE DE JEU %%
%%%%%%%%%%%%%%%%%%%

start :-
    initial_grid(Grid),
    play_game(Grid).

play_game(Grid) :-
    print_grid(Grid),
    write('\n\nX : Vous | O : IA\n'),
    write('\nEntrez un coup (colonne 1-7) : '),
    read(Col),
    (
        play_move(Grid, Col, x, NewGrid),
        (   check_victory(NewGrid, x)
        ->  print_grid(NewGrid),
            write('\n\nX gagne !\n\n')
        ;   egalite(NewGrid) 
        -> print_grid(NewGrid),
           write('\n\nEgalité !\n\n');
        ai_move(NewGrid, NewGrid1),
            (   check_victory(NewGrid1, o)
            ->  print_grid(NewGrid1),
                write('\n\nO gagne !\n\n')
            ;   egalite(NewGrid1) 
            -> print_grid(NewGrid1),
               write('\n\nEgalité !\n\n');
            play_game(NewGrid1)
            )
        )
    ;   write('Coup invalide, essayez de nouveau.\n'),
        play_game(Grid)
    ).
