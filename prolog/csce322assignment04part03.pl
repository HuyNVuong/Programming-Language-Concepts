fewestMoves(Game,[-1,-1]):-
    nth1(1, Game, Row),
    length(Row, NumCols),
    length(Game, NumRows),
    findPlayerOne(Game, Y, X),
    writeln(Y),
    writeln(X),
    writeln(NumCols),
    writeln(NumRows).

findPlayerOne(Game, Y, X):-
    nth1(1, Game, Row),
    length(Row, LengthOfRow),
    gameToList(Game, List),
    nth0(N, List, 1),
    Y is floor(div(N, LengthOfRow)),
    X is mod(N, LengthOfRow).

getFourRow([A,B,C,D|_], Row):-
    Row = [A,B,C,D].

checkFour([P1,P2,P3,P4]):-
    P1 = 1, P2 = 1, P3 = 1, P4 = 1.

checkPossibleWin([1,P2,P3,P4]):-
    (P2 = 1; P2 = -),
    (P3 = 1; P3 = -),
    (P4 = 1; P4 = -)
    .

at([Head|_], Head, 0).
at([_|Tail], Piece, N):-
    at(Tail, Piece, NP1),
    NP1 is N + 1.
