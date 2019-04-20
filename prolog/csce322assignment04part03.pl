fewestMoves(Game, Moves):-
    findPlayer(Game, 1, Row, Col),
    RowFrom is Row - 1,
    RowTo is Row - 3,
    pathToWinCol(Col, RowFrom, RowTo, Game, Moves)
    .

pathToWinCol(Col, RowTo, RowTo, _, [Col]).

pathToWinCol(Col, RowFrom, RowTo, Game, NewMoves):-
    RowFrom >= RowTo,
    RowFromM1 is RowFrom - 1,
    (
        (at(Game, RowFrom, Col, -),
        pathToWinCol(Col, RowFromM1, RowTo, Game, Moves),
        append([Col], Moves, NewMoves));
        (at(Game, RowFrom, Col, 1),
        pathToWinCol(Col, RowFromM1, RowTo, Game, Moves),
        append([], Moves, NewMoves))
    )
    .
