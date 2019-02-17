module.exports = {
    onePlayerManyMoves: onePlayerManyMoves
}

var helpers = require( './helpers' );

class Point {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    slopeTo(other) {
        return (this.x - other.x) == (this.y - other.y);
    }
    equals(other) {
        return (this.x == other.x && this.y == other.y);
    }
}

function onePlayerManyMoves( game ){
    
    var playerSet = new Map();
    var n = 0;
    function preprocess( game ) {
        for (var y = 0; y < game.length; y++) {
            for (var x = 0; x < game[y].length; x++) {
                if(game[y][x] != '-') {
                    if (playerSet.has(game[y][x])) {
                        playerSet.get(game[y][x]).add(new Point(y, x));
                    } else {
                        var coorSet = new Set();
                        coorSet.add(new Point(y, x));
                        playerSet.set(game[y][x], coorSet);
                    }
                    if (n < game[y][x]) {
                        n = game[y][x];
                    }
                }
            }
        }
        return;
    };

    function checkWinner(playerPlayed) {
        var playerCoorSet = playerSet.get(playerPlayed);
        var countY = new Map();
        var slopeCount = new Map();
        var rowCombo = 0;
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
        for (var p = 0; p < playerCoorSet.length; p++) {
            var point = playerCoorSet[p];
            if (countY.has(point.y)) {
                countY.set(point.y, countY.get(point.y) + 1); 
                if (countY.get(point.y) >= 4) {
                    return true;
                } 
            } else {
                countY.set(point.y, 1);
            }
        }
        return false;
    }

    function inGameMove( moves ) {
        preprocess(game);
        for (var m = 0; m < moves.length; m++) {
            var move = moves[m];
            for(var i = 0; i < game.length; i++) {
                if (game[i][move - 1] != '-') {
                    game[i - 1][move - 1] = '1';
                    break;
                } else if (i == game.length - 1) {
                    game[i][move - 1] = '1';
                    break;
                }
            }
            if (playerSet.has('1')) {
                playerSet.get('1').add(new Point(i - 1, move - 1));
            } else {
                var coorSet = new Set();
                coorSet.add(new Point(i - 1, move - 1));
                playerSet.set('1', coorSet);
            }
            if(checkWinner('1')) {
                break;
            }      
        }
        return game;      
    }
    return inGameMove;
}