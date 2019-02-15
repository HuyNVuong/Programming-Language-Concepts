grammar csce322assignment01part02;

@header {
	/*
	 * @author Huy Vuong
	 * This program find scan the connectFour file and find syntax and semantic errors
	 * Input file structure will need to retain in order to find the semantic erros.
	 * Tree walk order doesn't matter
	 */
	import java.util.*;
}

@members {
	Set<Integer> players = new HashSet<Integer>();
	Set<String> seen = new HashSet<String>();
	ArrayList<Integer> playerMoves = new ArrayList<Integer>();
	ArrayList<Integer> allMoves = new ArrayList<Integer>();
	int rowCount = 1;
	int columnCount = 0;
	int numCols;
	int numMoves = 0;
}
// rules
connectFour
	: (movesAndGame
	| gameAndMoves
	| err)
	( EOF {
		boolean error = false;
//		System.out.println(rowCount + " " + columnCount);
		if (players.size() < 2) {
			System.out.println("SEMANTIC PROBLEM 1 ");
			error = true;
	 	}
		if (rowCount > 10 || rowCount < 6) {
			System.out.println("SEMANTIC PROBLEM 2 ");
			error = true;
		}
		if (columnCount > 10 || columnCount < 6) {
			System.out.println("SEMANTIC PROBLEM 3");
			error = true;
		}
		// BONUS BONUS : checking if all moves are valid
		// No test case for it apparently :|
		for (int move : allMoves) {
			if (move < 1 || move > numCols) {
				System.out.println("SEMANTIC PROBLEM 4");
				error = true;
				break;
			}
		}
		if(!error) {
			System.out.println(playerMoves.size() + " pieces have been played");
		}

 	     }
	 | err)
	;

// Sub rules
moveEnd : MoveEnd;
moveBegin : MoveBegin;
movesTag : MovesTag;
gameTag : GameTag;
gameSymbol : GameSymbol;
sectionBegin : SectionBegin;
endr : Endr ;
sectionEnd : SectionEnd;
gameBegin : GameBegin ;
gameEnd  : GameEnd ;
err : ERR {System.out.println("SYNTAX PROBLEM ON LINE " + $ERR.line); System.exit(1);};
// Numerical rules
// Numerical rules
number : NUMBER ;
// Find all tokens inside game and move section using recursion
movesSection : (NUMBER { allMoves.add(Integer.parseInt($NUMBER.text)); numMoves += 1; } | Cols )
	       (MoveEnd
		{ if (numMoves < 2) {
			System.out.println("SYNTAX PROBLEM ON LINE " + $MoveEnd.line);
			System.exit(1);
		  }
		}
	     | movesSection);
gameSection  : (NUMBER { players.add(Integer.parseInt($NUMBER.text)); playerMoves.add(Integer.parseInt($NUMBER.text));
			 columnCount += 1; }
	     | GameSymbol { columnCount += 1; }
	     | Endr
	     {  rowCount += 1;
		numCols = columnCount;
		if (columnCount < 4) {
			System.out.println("SYNTAX PROBLEM ON LINE " + $Endr.line);
			System.exit(1);
		}
		columnCount = 0;
	     } )
	       (GameEnd
		 { if (rowCount < 4 || columnCount < 4){
			System.out.println("SYNTAX PROBLEM ON LINE " + $GameEnd.line);
			System.exit(1);
		   }
	         }
	     | gameSection);

// file start with either moves-game or game-moves
movesAndGame :
		MovesTag
		{ if (seen.contains("moves")) {
			System.out.println("SYNTAX PROBLEM ON LINE " + $MovesTag.line);
			System.exit(1);
		  } else {
			seen.add("moves");
		 }
		}
	       SectionBegin MoveBegin movesSection SectionEnd
	       GameTag
		{ if (seen.contains("game")) {
   			System.out.println("SYNTAX PROBLEM ON LINE " + $MovesTag.line);
   			System.exit(1);
   		  } else {
   			seen.add("game");
   		 }
   		}

		   SectionBegin GameBegin gameSection SectionEnd
	     ;
gameAndMoves :
		   GameTag
		   { if (seen.contains("game")) {
		   	System.out.println("SYNTAX PROBLEM ON LINE " + $MovesTag.line);
		   	System.exit(1);
		     } else {
		   	seen.add("game");
		    }
		   }
		   SectionBegin GameBegin gameSection SectionEnd
	       MovesTag
		   { if (seen.contains("moves")) {
		   	System.out.println("SYNTAX PROBLEM ON LINE " + $MovesTag.line);
		   	System.exit(1);
		     } else {
		   	seen.add("moves");
		    }
		   }
		   SectionBegin MoveBegin movesSection SectionEnd
	     ;

// tokens section
Cols : [_];
// Section title
MovesTag : 'moves';

GameTag : 'game';

// Numberical tokens
NUMBER : [0-9]+;
// Game symbol
GameSymbol : [-];

// Game row
Endr : '|';

// Section begining and ending
SectionBegin : '/*';
SectionEnd   : '*/';

// Game Begining and Ending
GameBegin : '[' ;
GameEnd   : ']' ;

// Moves begining and Ending
MoveBegin : '{' ;
MoveEnd   : '}' ;

// Ignore space, tabs, newlines and extranous char
WS  : [ \t\n\r]+ -> skip;
ERR : .;
