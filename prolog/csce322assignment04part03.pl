fewestMoves(Game, Result):-
    findPlayer(Game, 1, Y, X),
    writeln(Y),
    writeln(X),
    checkFourCol(Game, Y, X),
    getCol(Game, 5, Col),
    writeln(Col),
    getFour(Col, Four),
    append(Four, [], Result).

getCol(Game, X, Col):-
    use_module(library(clpfd)),
    transpose(Game, T),
    nth1(X, T, Col).

getFour([A,B,C,D|_], [A,B,C,D]).

movesToWinCol(_, YP3, YP3, _, []).

movesToWinCol(Game, Y, _, X, Moves):-
    writeln(Moves),
    at(Game, Y, X, 1) -> (movesToWinCol(Game, YP1, _, X, Moves), YP1 is Y - 1);
    (movesToWinCol(Game, YP1, _, X, NewMoves), append([Y], Moves, NewMoves), YP1 is Y - 1)
    .

checkFourRowToRight(Game, Y, X):-
    (at(Game, Y, X + 1, 1); at(Game, Y, X + 1, -)),
    (at(Game, Y, X + 2, 1); at(Game, Y, X + 2, -)),
    (at(Game, Y, X + 3, 1); at(Game, Y, X + 3, -))
    .

checkFourRowToLeft(Game, Y, X):-
    (at(Game, Y, X - 1, 1); at(Game, Y, X - 1, -)),
    (at(Game, Y, X - 2, 1); at(Game, Y, X - 2, -)),
    (at(Game, Y, X - 3, 1); at(Game, Y, X - 3, -))
    .

checkFourCol(Game, Y, X):-
    (at(Game, YM1, X, 1); at(Game, YM1, X, -)),
    (at(Game, YM2, X, 1); at(Game, YM2, X, -)),
    (at(Game, YM3, X, 1); at(Game, YM3, X, -)),
    YM1 is Y - 1, YM2 is Y - 2, YM3 is Y - 3
    .
