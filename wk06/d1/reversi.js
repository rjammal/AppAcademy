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
}

Board.prototype.validMove = function(position, color) {
    if (typeof this.grid[position[1]][position[0]] !== "undefined") {
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
            // TODO actually flip
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