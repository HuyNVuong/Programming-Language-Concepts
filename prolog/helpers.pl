:- module( helpers,
	 [ readConnectFourFile/3
	 , printGame/1
	 , count/3
	 , gameToList/2
	 , row/3
	 , at/4
	 , findPlayer/4
	 , columnAt/3
	 ]
    ).

prefix([_],[]).
prefix([H|T],[H|PreT]):-
    prefix(T,PreT).

readConnectFourFile(File,Moves,Game):-
    open(File,read,Input),
    read(Input,Moves),
    readGame(Input,Temp),
    prefix(Temp,Game),
    close(Input).

readGame(Input,[]):-
    at_end_of_stream(Input),
    !.
readGame(Input,[Row|Rows]):-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    readGame(Input,Rows).

printGame(Game):-
    writeln(game),
    printRows(Game).

printRows([]).
printRows([Row|Rows]):-
    writeln(Row),
    printRows(Rows).

row(M, N, Row) :-
    nth1(N, M, Row).

count(_, [], 0).
count(Piece, [Head|Tail], N):-
	Piece \= Head,
	count(Piece, Tail, N).
count(Piece, [Piece|Tail], NP1):-
	count(Piece, Tail, N),
	NP1 is N + 1.

gameToList([Row], Row).
gameToList([Head|Tail], NewList):-
	gameToList(Tail, List),
	append(Head, List, NewList)
	.

findPlayer(Game, Player, Y, X):-
    nth1(1, Game, Row),
    length(Row, LengthOfRow),
    gameToList(Game, List),
    nth0(N, List, Player),
    Y is (floor(div(N, LengthOfRow)) + 1),
    X is (mod(N, LengthOfRow) + 1).

rowAt([H|_], 1, H):-!.
rowAt([_|T], I, P):-
	IM1 is I - 1,
	rowAt(T, IM1, P).

columnAt([], _, []).
columnAt([H|T], I, [R|P]):-
	rowAt(H, I, R),
	columnAt(T, I, P).

at(Game, Y, X, Val):-
	nth1(Y, Game, Row),
	nth1(X, Row, Val).
