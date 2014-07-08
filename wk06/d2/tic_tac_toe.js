(function (root) {
    var TTT = root.TTT = (root.TTT || {});
    var readline = require('readline');
    var reader = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
    
    var Game = TTT.Game = function() {
        this.board = new Board();
        this.humanTurn = true;
    };
    
    var Board = TTT.Board = function() {
        this.grid = [[' ', ' ', ' '],[' ', ' ', ' '],[' ', ' ', ' ']];
    };
    
    Game.prototype.run = function() {
        console.log(this.board.toString());
        if (this.board.winner()) {
            console.log("Congratulations, " + this.board.winner() + "!");
        } else if (this.humanTurn) {
            this.humanMove();
        } else {
            this.computerMove();
        }
    };
    
    Game.prototype.humanMove = function() {
        var that = this;
        reader.question("Type the column: ", function(columnString) {
            reader.question("Type the row: ", function(rowString) {
                var row = parseInt(rowString);
                var col = parseInt(columnString);
                if (row < 0 || row > 2 || col < 0 || col > 2) {
                    console.log("Invalid, choose a number between 0 and 2.");
                    that.humanMove();
                } else if (that.board.empty(col, row)) {
                    that.board.placeMark(col, row, 'X');
                    that.humanTurn = false;
                    that.run();
                } else {
                    console.log("Try again.");
                    that.humanMove();
                }
            });
        });
    };
    
    Game.prototype.computerMove = function() {
        // check for winning moves
        for (var x = 0; x < 3; x++) {
            for (var y = 0; y < 3; y++) {
                if (this.board.empty(x, y)) {
                    this.board.placeMark(x, y, 'O');
                    if (this.board.won('O')) {
                        console.log(this.board.toString());
                        console.log("Computer wins.");
                        return;
                    } else {
                        this.board.placeMark(x, y, ' ');
                    }
                }
            }
        }
        // make a random move
        var potentialX, potentialY;
        do {
            potentialX = Math.floor(Math.random() * 3);
            potentialY = Math.floor(Math.random() * 3);
        } while (!this.board.empty(potentialX, potentialY));
        this.board.placeMark(potentialX, potentialY, 'O'); 
        this.humanTurn = true;
        this.run();
    };
    
    Board.prototype.toString = function() {
        var result = '';
        for (var y = 0; y < 3; y++) {
            result += this.grid[y].join('|');
            if (y < 2) {
                result += '\n-----\n';
            } else {
                result += '\n';
            }
        }
        return result;
    };
    
    Board.prototype.getSpace = function(x, y) {
        return this.grid[y][x];
    };
    
    Board.prototype.empty = function(x, y) {
        return this.getSpace(x, y) === ' ';
    };
    
    Board.prototype.placeMark = function(x, y, mark) {
        this.grid[y][x] = mark;
    };
    
    Board.prototype.won = function(mark) {
        for (var y = 0; y < this.grid.length; y++) {
            // rows
            if (this.getSpace(0, y) === mark &&
                    this.getSpace(0, y) === this.getSpace(1, y) && 
                    this.getSpace(1, y) === this.getSpace(2, y)) {
                return true;
            }
            // columns
            if (this.getSpace(y, 0) === mark &&
                    this.getSpace(y, 0) === this.getSpace(y, 1) && 
                    this.getSpace(y, 1) === this.getSpace(y, 2)) {
                return true;
            }
        }
        // diagonals
        if (this.getSpace(0, 0) === mark &&
                this.getSpace(0, 0) === this.getSpace(1, 1) && 
                this.getSpace(1, 1) === this.getSpace(2, 2)) {
            return true;
        }
        if (this.getSpace(0, 2) === mark &&
                this.getSpace(0, 2) === this.getSpace(1, 1) && 
                this.getSpace(1, 1) === this.getSpace(2, 0)) {
            return true;
        }
        return false;
    };
    
    Board.prototype.winner = function() {
        if (this.won('X')) {
            return 'X';
        } else if (this.won('O')) {
            return 'O';
        } else {
            return false;
        }
    };
        
})(this);

var g = new this.TTT.Game();

g.run();