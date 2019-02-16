var helpers = require( './helpers' );
var part = require( './csce322assignment02part02' );

var moves = helpers.readMovesFile('test01.moves.cnf');
var game = helpers.readGameFile('test01.game.cnf');
var beforeM = moves.slice(0);
var beforeG = game.slice(0);

var theFunction = part.onePlayerManyMoves( beforeG );
var after = theFunction( beforeM );
console.log( 'game' );
helpers.printGame( after );