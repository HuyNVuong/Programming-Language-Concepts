var helpers = require( './helpers' );
var part = require( './csce322assignment02part04' );

var moves = helpers.readMovesFile('test03.moves.cnf');
var game = helpers.readGameFile('test03.game.cnf');
var beforeM = moves.slice(0);
var beforeG = game.slice(0);

var theFunction = part.manyPlayersManyMoves( beforeG );
var after = theFunction( beforeM );
console.log( 'game' );
helpers.printGame( after );