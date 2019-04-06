occupiedSpaces(Game) :-
    length(Game, NumOfRows),
    row(Game, 1, Row),
    length(Row, NumOfCols),
    gameToList(Game, List),
    count(-, List, EmptySpaces),
    EmptySpaces >= round((NumOfCols * NumOfRows * 0.9))
    .
