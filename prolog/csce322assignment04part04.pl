notDiagonal(Game):-
    not(isDiagonal(Game))
    .

isDiagonal(Game):-
    between(1, 9, Player),
    findPlayer(Game, Player, Y, X),
    YP1 is Y + 2, XP1 is X + 2, XM1 is X,
    (at(Game, YP1, XP1, Player);
    at(Game, YP1, XM1, Player))
    .
