module.exports = {
    onePlayerManyMoves: onePlayerManyMoves
}

var helpers = require( './helpers' );

class Point {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
}

function onePlayerManyMoves( game ){
    
    var playerSet = new Map();
    var preDef = new Map([[1, '1'], [2, '2'], [3, '3'], [4, '4'],
                          [5, '5'], [6, '6'], [7, '7'], [8, '8'],
                          [9, '9'], [10, '10'], [11, '11'], [12, '12']]);
    var n = 0;
    function preprocess( game ) {
        for (var y = 0; y < game.length; y++) {
            for (var x = 0; x < game[y].length; x++) {
                if(game[y][x] != '-') {
                    if (playerSet.has(game[y][x])) {
                        playerSet.get(game[y][x]).push(new Point(y, x));
                    } else {
                        var coorSet = new Array();
                        coorSet.push(new Point(y, x));
                        playerSet.set(game[y][x], coorSet);
                    }
                }
                if (n < game[y][x]) {
                    n = game[y][x];
                }
            }
        }
        return;
    };

    function checkWinner(playerPlayed) {
        var playerCoorSet = playerSet.get(playerPlayed);
        console.log(playerCoorSet);
        for (var p = 0; p < playerCoorSet.length; p++) {
            var point = playerCoorSet[p];
            
        }
        return false;
    }

    function inGameMove( moves ) {
        preprocess(game);
        var players = new Array(n);
        for (var p = 1; p <= n; p++) {
            players[p - 1] = p;
        }
        var seen = new Set();
        for (var m = 0; m < moves.length; m++) {
            var move = moves[m];
            var player = preDef.get(players[m % parseInt(n, 10)]);
            for(var i = 0; i < game.length; i++) {
                if (game[i][move - 1] != '-') {
                    game[i - 1][move - 1] = player;
                    break;
                }
            }
            
            if (playerSet.has(player)) {
                playerSet.get(player).push(new Point(i - 1, move - 1));
            } else {
                var coorSet = new Array();
                coorSet.push(new Point(i - 1, move - 1));
                playerSet.set(player, coorSet);
            }
            if(checkWinner(player)) {
                break;
            }
            seen.add(player);
            if (seen.size == n) {
                break;
            }       
        }
        // console.log(playerSet);
        return game;      
    }
    return inGameMove;
}