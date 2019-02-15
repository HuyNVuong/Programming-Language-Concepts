grammar csce322assignment01part01;

@header {
	/*
	 * @author Huy Vuong
	 * This program find scan the connectFour file according to
	 * connectFour game rule
	 * A token recognition error will be raised and the program
	 * will be terminated if tokens syntax are wrong.
	 */
}
// rules
connectFour
	: ( movesAndGame
	| gameAndMoves )
	  ( err 
	| EOF { System.out.println("End of File"); } )
	;

// Sub rules 
/*
	Strat :  expr | error
*/
moveEnd : MoveEnd { System.out.println("End of List"); } | err;
moveBegin : MoveBegin { System.out.println("Beginning of List"); } | err;
movesTag : MovesTag { System.out.println("Moves Section"); } | err;
gameTag : GameTag { System.out.println("Game Section"); } | err;
gameSymbol : GameSymbol { System.out.println("Space: Empty");} | err;
sectionBegin : SectionBegin { System.out.println("Beginning of Section"); } | err;
endr : Endr { System.out.println("End of Row"); } | err;
sectionEnd : SectionEnd { System.out.println("End of Section"); } | err;
gameBegin : GameBegin { System.out.println("Start of Game"); } | err;
gameEnd  : GameEnd { System.out.println("End of Game"); } | err;
err : ERR {System.out.println("SYNTAX PROBLEM ON LINE " + $ERR.line); System.exit(1);} ;
// Numerical rules
number : NUMBER { System.out.println("Number: " + $NUMBER.text); };
// Find all tokens inside game and move section

movesSection : (number | cols) ( moveEnd | movesSection); // If not end of move, recurse back
gameSection  : (number | gameSymbol | endr)
	       (gameEnd | gameSection);

// file start with either moves-game or game-moves

movesAndGame : (movesTag sectionBegin moveBegin movesSection sectionEnd
	       gameTag sectionBegin gameBegin gameSection sectionEnd)
	     | err
	     ;
gameAndMoves : (gameTag sectionBegin gameBegin gameSection sectionEnd
	       movesTag sectionBegin moveBegin movesSection sectionEnd)
	     | err
	     ;


// tokens section
Cols : [_];
cols : Cols;
// Section title
MovesTag : 'moves';

GameTag : 'game';


// Numberical tokens
NUMBER : [0-9]+;
// Game symbol
GameSymbol : [-]+;

// Game row
Endr : '|' ;

// Section begining and ending
SectionBegin : '/*';
//	catch[RecognitionException e] { System.out.println("SYNTAX ERROR ON LINE " + $ERR.line); System.exit(1); }
SectionEnd   : '*/';
// Game Begining and Ending
GameBegin : '[' ;
GameEnd   : ']' ;


// Moves begining and Ending
MoveBegin : '{';
MoveEnd   : '}' ;
// Ignore space, tabs, newlines and extranous char
WS  : [ \t\n\r]+ { skip();};
ERR : .;
