columnsAndMoves(Game,Moves):-
    row(Game, 1, Row),
    length(Row, NumOfCols),
    length(Moves, NumOfMoves),
    ((0 is mod(NumOfCols, 2), 0 is mod(NumOfMoves, 2));
     (1 is mod(NumOfCols, 2), 1 is mod(NumOfMoves, 2)))
    .
