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
          (MovesWithLength));
    MovesWithLength is 4.

findAllMoves(Game, Moves):-
    findPlayer(Game, 1, Row, Col),
    (
        pathToWinCol(Game, Row, Col, Moves);
        pathToWinRow(Game, Row, Col, Moves)
        % pathToWinDiag(Game, Row, Col, Moves)
    )
    .

findAllMoves(Game, Moves):-
    preProgramCol(Game, Moves);
    preProgramRow(Game, Moves)
    .

preProgramCol(Game, Moves):-
    nth1(1, Game, Row),
    length(Row, NumCols),
    between(1, NumCols, P),
    Moves = [P,P,P,P]
    .

preProgramRow(Game, AllMoves):-
    length(Game, NumRows),
    length(Game, NumCols),
    between(1, NumRows, Y),
    between(1, NumCols, X),
    findFourBases(Game, Y, X),
    XP1 is X + 1, XP2 is X + 2, XP3 is X + 3,
    Moves = [X, XP1, XP2, XP3],
    permutation(Moves, AllMoves)
    .

findFourBases(Game, Y, X):-
    XP1 is X + 1, XP2 is X + 2, XP3 is X + 3, YP1 is Y + 1,
    (
        (at(Game, Y, X, -),
         at(Game, Y, XP1, -),
         at(Game, Y, XP2, -),
         at(Game, Y, XP3, -)),
        (not(at(Game, YP1, X, -)),
         not(at(Game, YP1, XP1, -)),
         not(at(Game, YP1, XP2, -)),
         not(at(Game, YP1, XP3, -)))
    )
    .

pathToWinDiag(Game, Row, Col, AllMoves):-
    RowFrom is Row - 1, RowTo is Row - 3,
    ColFromLeft is Col - 1, ColToLeft is Col - 3,
    ColFromRight is Col + 1, ColToRight is Col + 3,
    (pathToWinDiagLeft(Game, ColFromLeft, RowFrom, ColToLeft, RowTo, Moves);
    pathToWinDiagRight(Game, ColFromRight, RowFrom, ColToRight, RowTo, Moves)),
    permutation(Moves, AllMoves).

pathToWinDiagLeft(Game, ColTo, RowTo, ColTo, RowTo, [ColTo, ColTo]):-
    at(Game, RowTo, ColTo, -),
    RowP1 is RowTo + 1,
    at(Game, RowP1, ColTo, -).

pathToWinDiagLeft(Game, ColTo, RowTo, ColTo, RowTo, [ColTo]):-
    at(Game, RowTo, ColTo, -),
    RowP1 is RowTo + 1,
    not(at(Game, RowP1, ColTo, -)).

pathToWinDiagLeft(Game, ColTo, RowTo, ColTo, RowTo, []):- at(Game, RowTo, ColTo, 1).

pathToWinDiagLeft(Game, ColFrom, RowFrom, ColTo, RowTo, NewMoves):-
    RowFrom >= RowTo, ColFrom >= ColTo,
    ColM1 is ColFrom - 1, RowM1 is RowFrom - 1,
    (
        (at(Game, RowFrom, ColFrom, -),
         RowP1 is RowFrom + 1, at(Game, RowP1, ColFrom, -),
         pathToWinDiagLeft(Game, ColM1, RowM1, ColTo, RowTo, Moves),
         append([ColFrom, ColFrom], Moves, NewMoves));
        (at(Game, RowFrom, ColFrom, -),
         RowP1 is RowFrom + 1, not(at(Game, RowP1, ColFrom, -)),
         pathToWinDiagLeft(Game, ColM1, RowM1, ColTo, RowTo, Moves),
         append([ColFrom], Moves, NewMoves));
        (at(Game, RowFrom, ColFrom, 1),
         pathToWinDiagLeft(Game, ColM1, RowM1, ColTo, RowTo, Moves),
         append([], Moves, NewMoves))
    )
    .

pathToWinDiagRight(Game, ColTo, RowTo, ColTo, RowTo, [ColTo, ColTo]):-
    at(Game, RowTo, ColTo, -),
    RowP1 is RowTo + 1,
    at(Game, RowP1, ColTo, -)
    .

pathToWinDiagRight(Game, ColTo, RowTo, ColTo, RowTo, [ColTo]):-
    at(Game, RowTo, ColTo, -),
    RowP1 is RowTo + 1,
    not(at(Game, RowP1, ColTo, -)).

pathToWinDiagRight(Game, ColTo, RowTo, ColTo, RowTo, []):- at(Game, RowTo, ColTo, 1).

pathToWinDiagRight(Game, ColFrom, RowFrom, ColTo, RowTo, NewMoves):-
    RowFrom >= RowTo, ColTo >= ColFrom,
    ColP1 is ColFrom + 1, RowM1 is RowFrom - 1,
    (
        (at(Game, RowFrom, ColFrom, -),
         RowP1 is RowFrom + 1, at(Game, RowP1, ColFrom, -),
         pathToWinDiagRight(Game, ColP1, RowM1, ColTo, RowTo, Moves),
         append([ColFrom, ColFrom], Moves, NewMoves));
        (at(Game, RowFrom, ColFrom, -),
         RowP1 is RowFrom + 1, not(at(Game, RowP1, ColFrom, -)),
         pathToWinDiagRight(Game, ColP1, RowM1, ColTo, RowTo, Moves),
         append([ColFrom], Moves, NewMoves));
        (at(Game, RowFrom, ColFrom, 1),
         pathToWinDiagRight(Game, ColP1, RowM1, ColTo, RowTo, Moves),
         append([], Moves, NewMoves))
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

pathToWinRowHelper(Row, ColTo, ColTo, Game, [ColTo, ColTo]):-
    at(Game, Row, ColTo, -),
    RowP1 is Row + 1,
    at(Game, RowP1, ColTo, -).

pathToWinRowHelper(Row, ColTo, ColTo, Game, [ColTo]):-
    at(Game, Row, ColTo, -),
    RowP1 is Row + 1,
    not(at(Game, RowP1, ColTo, -)).

pathToWinRowHelper(Row, ColTo, ColTo, Game, []):- at(Game, Row, ColTo, 1).

pathToWinRowHelper(Row, ColFrom, ColTo, Game, NewMoves):-
    ColTo >= ColFrom,
    ColFromP1 is ColFrom + 1,
    (
        (at(Game, Row, ColFrom, -),
        RowP1 is Row + 1, at(Game, RowP1, ColFrom, -),
        pathToWinRowHelper(Row, ColFromP1, ColTo, Game, Moves),
        append([ColFrom, ColFrom], Moves, NewMoves));
        (at(Game, Row, ColFrom, -),
        RowP1 is Row + 1, not(at(Game, RowP1, ColFrom, -)),
        pathToWinRowHelper(Row, ColFromP1, ColTo, Game, Moves),
        append([ColFrom], Moves, NewMoves));
        (at(Game, Row, ColFrom, 1),
        pathToWinRowHelper(Row, ColFromP1, ColTo, Game, Moves),
        append([], Moves, NewMoves))
    )
    .
