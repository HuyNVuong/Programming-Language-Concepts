module.exports = {
    readMovesFile:readMovesFile,
    readGameFile:readGameFile,
    printMoves:printMoves,
    printGame:printGame,
    checkWinner:checkWinner,
    playerSet:playerSet
}

var playerSet = new Map();

function readMovesFile( file ) {
    var text;
    var moves = [];
    var rows = [];
    var mvs = [];
    var filesystem = require( 'fs' );

    text = filesystem.readFileSync( file );
    rows = text.toString().split( "\n" );
    rows.pop();
    moves = rows[0].split( ',' );
    
    for( var m = 0; m < moves.length; m++ ){
	mvs[m] = parseInt( moves[m] );
    }
    
    return mvs;
}

function readGameFile( file ) {
    var text;
    var game = [];
    var rows = [];
    var filesystem = require( 'fs' );

    text = filesystem.readFileSync( file );
    rows = text.toString().split( "\n" );
    rows.pop();
    
    for( var r = 0; r < rows.length; r++ ){
	game[r] = rows[r].split( ',' );
    }

    return game;
}


function printMoves( moves ){
    console.log( moves );
}

function printGame( game ){
    for( var r = 0; r < game.length; r++ ){
	console.log( game[r] );
    }
}

function checkWinner(playerPlayed, game) {
    var playerCoorSet = playerSet.get(playerPlayed);
    var slopeCount = new Map();
    var coorOrderedByX = Array.from(new Set(playerCoorSet)).sort((p1, p2) => (p1.x > p2.x) ? 1 : -1);
    console.log(coorOrderedByX);
    for (var y = 0; y < game.length; y++) {
        var piece = -1;
        rowCombo = 1;
        for (var x = 0; x < game[y].length; x++) {
            if(piece != '-') {
                if (piece != game[y][x]) {
                    rowCombo = 1; 
                } else {
                    rowCombo += 1;
                }
                if(rowCombo == 4) {
                    return true;
                }
            } else {
                rowCombo = 1;
            }
            piece = game[y][x];
        }
    }
    for (var point of playerCoorSet) {
        for (var other of playerCoorSet) {
            if(point.slopeTo(other)) {
                if (slopeCount.has(point)) {
                    slopeCount.get(point).add(other);
                } else {
                    slopeToSet = new Set();
                    slopeToSet.add(other);
                    slopeCount.set(point, slopeToSet);
                }
                if (slopeCount.get(point).size >= 4) {
                    console.log(slopeCount);
                    return true;
                }
            }
        }
    }
    return false;
}