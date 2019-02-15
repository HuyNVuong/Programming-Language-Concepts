module.exports = {
    manyPlayersOneMove: manyPlayersOneMove
}

var helpers = require( './helpers' );

class Point {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    slopeTo(other) {
        return Math.abs(this.x - other.x) == Math.abs(this.y - other.y);
    }
    equals(other) {
        return (this.x == other.x && this.y == other.y);
    }
}

function manyPlayersOneMove( game ){
    
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
        var countY = new Map();
        var slopeCount = new Map();
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
            for (var op = 0; op < playerCoorSet.length; op++) {
                var other = playerCoorSet[op];
                if(!point.equals(other) && point.slopeTo(other)) {
                    if (slopeCount.has(point)) {
                        slopeCount.get(point).add(other);
                    } else {
                        slopeToSet = new Set();
                        slopeToSet.add(other);
                        slopeCount.set(point, slopeToSet);
                    }
                    if (slopeCount.get(point).size >= 4) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    function inGameMove( moves ) {
        preprocess(game);
        var seen = new Set();
        var players = new Array(n);
        for (var p = 1; p <= n; p++) {
            players[p - 1] = p;
        }
        for (var m = 0; m < moves.length; m++) {
            var move = moves[m];
            var player = preDef.get(players[m % parseInt(n, 10)]);
            
            for(var i = 0; i < game.length; i++) {
                // console.log(i, move - 1, game[i][move - 1]);
                if (game[i][move - 1] != '-') {
                    game[i - 1][move - 1] = player;
                    break;
                } else if (i == game.length - 1) {
                    game[i][move - 1] = player;
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
            seen.add(player);
            if (seen.size == 4) {
                break;
            }
            if(checkWinner(player)) {
                break;
            }
        }
        // console.log(playerSet);
        return game;      
    }
    return inGameMove;
}