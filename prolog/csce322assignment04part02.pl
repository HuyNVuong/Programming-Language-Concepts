occupiedSpaces(Game) :-
    gameToList(Game, List),
    count(-, List, EmptySpaces),
    length(List, GameSize),
    EmptySpaces >= ceil(GameSize * 0.9)
    .
