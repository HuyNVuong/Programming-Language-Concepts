:- module( helpers,
	 [ readConnectFourFile/3
	 , printGame/1
	 , row/3
	 ]
    ).

readConnectFourFile(File,Moves,Game):-
    open(File,read,Input),
    read(Input,Moves),
    readGame(Input,Game),
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
% Helpers function
% length(List,Length)
