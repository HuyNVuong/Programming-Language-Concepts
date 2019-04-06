columnsAndMoves(Game,Moves):-
    findall(length(Moves, NumMoves), length(row(Game,1,_), NumCols))
            (0 is mod(NumMoves, 2), 0 is mod(NumCols, 2));
            (1 is mod(NumMoves, 2), 1 is mod(NumCols, 2))
           .
