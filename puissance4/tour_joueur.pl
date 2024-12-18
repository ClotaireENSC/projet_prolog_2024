:- module(tour_joueur, [joueur_tour/1]).

:- use_module(grille).
:- use_module(check_position).

joueur_tour(Grille) :-
    showGrid(Grille),
    write("C'est ton tour, choisis une colonne où déposer ton pion : "),
    read(Position),
    (   integer(Position),
        Position >= 1, Position =< 6
    ->  write('Vous avez entré : '), write(Position), nl,
        get_column(Grille, Position, Column),
        check_position(Column, Index, 1),
        (   Index \= -1
        ->  replace_at_index(Index, Column, 'X', NewColumn),
            update_grille(Grille,Position,NewColumn,NewGrille),
            joueur_tour(NewGrille)
            
            
        ;   write('Colonne pleine, choisissez une autre colonne.'), nl,
            joueur_tour(Grille)
        )
    ;   write('Entrée invalide, veuillez entrer un entier entre 1 et 6'), nl,
        joueur_tour(Grille)
    ).