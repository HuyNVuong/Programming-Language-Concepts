fewestMoves(Game,[-1,-1]):-
    nth1(1, Game, Row),
    length(Row, NumCols),
    length(Game, NumRows),
    findPlayer(Game, 1, Y, X),
    writeln(Y),
    writeln(X),
    writeln(NumCols),
    writeln(NumRows).

% findRowForWinner(Game):-
%     Game is [Row|Rows],
%     checkFour(Row)
checkFourRow([_,_,_]):- false.

checkFourRow([A,B,C,D|_]):-
    % (length(Row, NumCols),
    % NumCols >= 4,
    % Row is [A,B,C,D|_],
    (A = 1,
    (B = 1; B = -),
    (C = 1; C = -),
    (D = 1; D = -));
    checkFourRow([B,C,D|_])
    .
