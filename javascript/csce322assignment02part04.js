module.exports = {
    manyPlayersManyMoves: manyPlayersManyMoves
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

function manyPlayersManyMoves( game ){
    
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
                        playerSet.get(game[y][x]).add(new Point(x, y));
                    } else {
                        var coorSet = new Set();
                        coorSet.add(new Point(x, y));
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
        for (var y = 0; y < game.length; y++) {
            for (var x = 0; x < game[y].length - 3; x++) {
                if (game[y][x] != '-') {
                    if (game[y][x] == playerPlayed && game[y][x + 1] == playerPlayed
                            && game[y][x + 2] == playerPlayed && game[y][x + 3] == playerPlayed) {
                                return true;
                            }
                }
            }
        }
        
        for (var y = 0; y < game.length - 3; y++) {
            for (var x = 0; x < game[y].length; x++) {
                if (game[y][x] != '-') {
                    if (game[y][x] == playerPlayed && game[y + 1][x] == playerPlayed
                            && game[y + 2][x] == playerPlayed && game[y + 3][x] == playerPlayed) {
                                return true;
                            }
                }
            }
        }

        for (var y = 0; y < game.length - 3; y++) {
            for (var x = 0; x < game[0].length; x++) {
                if (game[y][x] != '-') {
                    if (x < game[0].length - 3) {
                        if (game[y][x] == playerPlayed && game[y + 1][x + 1] == playerPlayed 
                            && game[y + 2][x + 2] == playerPlayed && game[y + 3][x + 3] == playerPlayed) {
                                return true;
                        }
                    }
                    if (x >= 3) {
                        if (game[y][x] == playerPlayed && game[y + 1][x - 1] == playerPlayed 
                            && game[y + 2][x - 2] == playerPlayed && game[y + 3][x - 3] == playerPlayed) {
                                return true;
                            }
                    }
                }
            }
        }

        return false;
    }

    function inGameMove( moves ) {
        preprocess(game);
        var players = new Array(n);
        for (var p = 1; p <= n; p++) {
            players[p - 1] = p;
        }
        for (var m = 0; m < moves.length; m++) {
            // console.log(playerSet);
            var move = moves[m];
            var player = preDef.get(players[m % parseInt(n, 10)]);
            
            for(var i = 0; i < game.length; i++) {
                if (game[i][move - 1] != '-') {
                    game[i - 1][move - 1] = player;
                    break;
                } else if (i == game.length - 1) {
                    game[i][move - 1] = player;
                }
            }
            if (playerSet.has(player)) {
                playerSet.get(player).add(new Point(move - 1, i - 1));
            } else {
                var coorSet = new Set();
                coorSet.add(new Point(move - 1, i - 1));
                playerSet.set(player, coorSet);
            }
            if(checkWinner(player)) {
                // console.log('someone wins');
                break;
            }
        }
        return game;      
    }
    return inGameMove;
}
