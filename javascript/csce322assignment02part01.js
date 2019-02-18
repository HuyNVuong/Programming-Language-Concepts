module.exports = {
    onePlayerOneMove: onePlayerOneMove
}

var helpers = require( './helpers' );

function onePlayerOneMove( game ){
    function moveInGame( move ){
        for(var i = 0; i < game.length; i++) {
            if (game[i][move - 1] != '-') {
                game[i - 1][move - 1] = '1';
                break;
            } else if (i == game.length - 1) {
                game[i][move - 1] = '1';
                break;
            }
        }
	    return game;
    }
    return moveInGame;
}