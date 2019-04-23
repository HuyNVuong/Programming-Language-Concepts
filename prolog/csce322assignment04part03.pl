fewestMoves(Game, Moves):-
    findAllMoves(Game, Moves),
    findAllMovesWithLength(Game, MovesWithLength),
    getShortestLength(MovesWithLength, (ShortestLength, _)),
    length(Moves, MovesLength),
    MovesLength = ShortestLength
    .

getShortestLength([(Length,Move)|_], (Length, Move)).

findAllMovesWithLength(Game, MovesWithLength):-
    setof((Length, Moves),
          (findAllMoves(Game, Moves), length(Moves, Length)),
          (MovesWithLength)).

findAllMoves(Game, Moves):-
    findPlayer(Game, 1, Row, Col),
    (
        pathToWinCol(Game, Row, Col, Moves);
        pathToWinRow(Game, Row, Col, Moves)
    )
    .

pathToWinCol(Game, Row, Col, Moves):-
    RowFrom is Row - 1,
    RowTo is Row - 3,
    pathToWinColHelper(Col, RowFrom, RowTo, Game, Moves).

pathToWinColHelper(Col, RowTo, RowTo, _, [Col]).

pathToWinColHelper(Col, RowFrom, RowTo, Game, NewMoves):-
    RowFrom >= RowTo,
    RowFromM1 is RowFrom - 1,
    (
        (at(Game, RowFrom, Col, -),
        pathToWinColHelper(Col, RowFromM1, RowTo, Game, Moves),
        append([Col], Moves, NewMoves));
        (at(Game, RowFrom, Col, 1),
        pathToWinColHelper(Col, RowFromM1, RowTo, Game, Moves),
        append([], Moves, NewMoves))
    )
    .

pathToWinRow(Game, Row, Col, AllMoves):-
    (
        (ColFrom is Col - 3, ColTo is Col,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves),
        permutation(Moves, AllMoves));
        (ColFrom is Col - 2, ColTo is Col + 1,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves),
        permutation(Moves, AllMoves));
        (ColFrom is Col - 1, ColTo is Col + 2,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves),
        permutation(Moves, AllMoves));
        (ColFrom is Col, ColTo is Col + 3,
        pathToWinRowHelper(Row, ColFrom, ColTo, Game, Moves),
        permutation(Moves, AllMoves))
    )
    .

pathToWinRowHelper(Row, ColTo, ColTo, Game, [ColTo]):- at(Game, Row, ColTo, -).

pathToWinRowHelper(Row, ColTo, ColTo, Game, []):- at(Game, Row, ColTo, 1).

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
