
:- use_module("puissance4/grille").

:- use_module("puissance4/check_win").
:- use_module("puissance4/tour_joueur").
:- use_module("puissance4/check_position").

% Test entry point
%%% JOUER SON TOUR %%%


start :-
    grilleInit(Liste),
    joueur_tour(Liste).


    





