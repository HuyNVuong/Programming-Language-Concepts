fewestMoves(Game, Moves):-
    findPlayer(Game, 1, Row, Col),
    RowFrom is Row - 1,
    RowTo is Row - 3,
    (pathToWinCol(Col, RowFrom, RowTo, Game, Moves);
    pathToWinRow(Game, Row, Col, Moves))
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

pathToWinRow(Game, Row, Col, Moves):-
    (
        (ColFrom is Col - 3, ColTo is Col - 1,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves));
        (ColFrom is Col - 2, ColTo is Col + 1,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves));
        (ColFrom is Col - 1, ColTo is Col + 2,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves));
        (ColFrom is Col, ColTo is Col + 3,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves))
    )
    .


pathToWinRowHelper(Row, ColTo, ColTo, _, [Row]).

pathToWinRowHelper(Row, ColFrom, ColTo, Game, NewMoves):-
    ColTo >= ColFrom,
    ColFromP1 is ColFrom + 1,
    (
        (at(Game, Row, ColFrom, -),
        pathToWinRowHelper(Row, ColFromP1, ColTo, Game, Moves),
        append([ColFrom], Moves, NewMoves));
        (at(Game, Row, ColFrom, 1),
        pathToWinRowHelper(Row, ColFromP1, ColTo, Game, Moves),
        append([], Moves, NewMoves))
    )
    .
