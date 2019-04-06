printSequences([]).
printSequences([Sequence|Sequences]):-
    writeln(Sequence),
    printSequences(Sequences).

loadHelpers:-
    ['helpers'],
    ['csce322assignment04part01'],
    ['csce322assignment04part02'],
    ['csce322assignment04part03'],
    ['csce322assignment04part04'].

part01:-
    readConnectFourFile('test01.cnf',Moves,Game),
    writeln(moves),
    writeln(Moves),
    printGame(Game),
    columnsAndMoves(Game,Moves).

part02:-
    readConnectFourFile('test01.cnf',_,Game),
    printGame(Game),
    occupiedSpaces(Game).

part03:-
    readConnectFourFile('test01.cnf',_,Game),
    printGame(Game),
    setof(Moves,fewestMoves(Game,Moves),AllMoves),
    writeln(moves),
    printSequences(AllMoves).

part04:-
    readConnectFourFile('test01.cnf',_,Game),
    printGame(Game),
    notDiagonal(Game).
