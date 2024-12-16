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
    print_grid(Q), nl,
    write(P).

%%%%%%%%%%%%%%%%%%%%%%
%% MOUVEMENT JOUEUR %%
%%%%%%%%%%%%%%%%%%%%%%

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

ai_move(Grid, NewGrid) :-
    random_between(1, 7, Col),
    play_move(Grid, Col, o, NewGrid).

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
        ->  print_grid(NewGrid),  % Affichage de la grille après le coup avant la victoire
            write('\n\nX gagne !\n\n')
        ;   ai_move(NewGrid, NewGrid1),
            (   check_victory(NewGrid1, o)
            ->  print_grid(NewGrid1),  % Affichage de la grille après le coup avant la victoire
                write('\n\nO gagne !\n\n')
            ;   play_game(NewGrid1)
            )
        )
    ;   write('Coup invalide, essayez de nouveau.\n'),
        play_game(Grid)
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
    diagonal(Grid, Diagonal),
    four_in_a_row(Diagonal, Player);
    reverse(Grid, Reversed),
    diagonal(Reversed, DiagonalReversed),
    four_in_a_row(DiagonalReversed, Player).

four_in_a_row([Player, Player, Player, Player|_], Player).
four_in_a_row([_, H|T], Player) :-
    four_in_a_row([H|T], Player).

diagonal(Grid, Diagonal) :-
    findall(E, (nth1(Index, Grid, Row), nth1(Index, Row, E)), Diagonal).

transpose([[]|_], []).
transpose(Matrix, [Row|Rest]) :-
    maplist(head_tail, Matrix, Row, Tails),
    transpose(Tails, Rest).

head_tail([H|T], H, T).
