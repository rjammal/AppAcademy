var directions = [
    [1, 1], 
    [1, 0], 
    [1, -1], 
    [0, -1], 
    [0, 1], 
    [-1, 1], 
    [-1, 0], 
    [-1, -1]
];

function Board() {
    this.grid = [];
    for (var i = 0; i < 8; i++) {
        this.grid.push(new Array(8));
    }
    this.grid[3][3] = new Piece("red");
    this.grid[4][4] = new Piece("red");
    this.grid[4][3] = new Piece("blue");
    this.grid[3][4] = new Piece("blue");
}

var b = new Board();
console.log(b);
console.log(b.grid[3][3]);

function Piece(color) {
    this.color = color;
}

function Game() {
    this.board = new Board();
    this.player1Turn = true;
}

Board.prototype.validMove = function(position, color) {
    if (!this.empty(positon[0], position[1])) {
        return false;
    }
    for (var i = 0; i < directions.length; i++) {
        var newPosition = this.moveInDirection(position, directions[i]);
        if (this.inBounds(newPosition)) {
            var adjColor = this.grid[newPosition[1]][newPosition[0]];
            if (typeof adjColor !== "undefined" && adjColor.color !== color) {
                newPosition = this.moveInDirection(newPosition, directions[i]);
                while (this.inBounds(newPosition) && typeof newPosition !== "undefined") {
                    if (this.grid[newPosition[1]][newPosition[0]].color === color) {
                        return true;
                    }
                    newPosition = this.moveInDirection(newPosition, directions[i]);
                }
            }
        } 
    }
    return false;
};

Board.prototype.flipPiece = function (position) {
    var piece = this.grid[position[1]][position[0]];
    if (piece.color === 'red') {
        piece.color = 'blue';
    } else if (piece.color === 'blue') {
        piece.color = 'red';
    }
};

Board.prototype.flipPieces = function(position, direction) {
    var piecesToFlip = [];
    var startColor = this.grid[position[1]][position[0]].color;
    position = this.moveInDirection(position, direction);
    while (this.inBounds(position) && typeof this.grid[position[1]][position[0]] !== 'undefined') {
        if (startColor !== this.grid[position[1]][position[0]].color) {
            piecesToFlip.push(position);
        } else {
            for (var i = 0; i < piecesToFlip.length; i++) {
                this.flipPiece(piecesToFlip[i]);
            }
            return;
        }
        position = this.moveInDirection(position, direction);
    }
};

Board.prototype.flipAllDirections = function (position) {
    for (var i = 0; i < directions.length; i++) {
        this.flipPieces(position, directions[i]);
    }
};

Board.prototype.inBounds = function (position) {
    var xValid = position[0] < 8 && position[0] > -1;
    var yValid = position[1] < 8 && position[1] > -1;
    return xValid && yValid;
};

Board.prototype.moveInDirection = function(position, direction) {
    return [position[0] + direction[0], position[1] + direction[1]];
};

Game.prototype.placePiece = function (position, color) {
    this.board[position[1]][position[0]] = new Piece(color);
};


Board.prototype.empty = function(x, y) {
    typeof this.grid[y][x] === "undefined";
};

Board.prototype.noValidMoves = function(color) {
    for (var y = 0; y < 8; y++) {
        for (var x = 0; x < 8; x++) {
            if (this.validMove([x, y], color)) {
                return false;
            }
        }
    }
    return true;
};

Game.prototype.over = function () {
    return this.board.noValidMoves('red') && this.board.noValidMoves('blue');
};

Game.prototype.score = function () {
    var result = {red: 0, blue: 0};
    for (var y = 0; y < 8; y++) {
       for (var x = 0; x < 8; x++) {
            var piece = this.board.grid[y][x];
            if (typeof piece !== 'undefined') {
                result[piece.color] += 1;
            }
       }
   }
   return result;
};

Game.prototype.run = function () {
    var game = this;
    var completionCallback = function() {
        if (game.over()) {
            console.log(game.score);
        } else {
            game.takeTurn( completionCallback );
        }
    }
    this.takeTurn( completionCallback );
};

Game.prototype.takeTurn = function ( completionCallback ) {
    
};