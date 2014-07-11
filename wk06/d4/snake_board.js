(function (root) {
  var SnakeGame = root.SnakeGame = (root.SnakeGame || {});

  var Board = SnakeGame.Board = function () {
    this.snake = new SnakeGame.Snake(new SnakeGame.Coord(250, 250));
    this.apples = [];
  };
  
  Board.prototype.renderCoords = function(coor) {
    if (this.snake.segments.containsCoord(coor)) {
      return 'snake';
    } else if (this.apples.containsCoord(coor)) {
      return 'apple';
    } else {
      return "empty";
    }
  };
  
  Board.prototype.moveSnake = function(){
    var head = this.snake.segment[0];
    var newHead = head.plus(this.snake.dir);
    var applePresent = this.apples.containsCoord(newHead);
    var snakePresent = this.snake.segments.constainsCoord(newHead);
    if (snakePresent) {
      throw "You lose";
    } else {
      this.snake.move(newHead, applePresent);
    }
  }
  
  
  Board.prototype.addApple = function() {
    var x = Math.floor(Math.random() * 500);
    var y = Math.floor(Math.random() * 500);
    var apple = new SnakeGame.Coord(x, y);
    if (this.snake.segments.containsCoord(apple)) {
      this.addApple();
    } else if (this.apples.containsCoord(apple)) {
      this.addApple();
    } else {
      this.apples.push(apple);
    }
  };
  
  Array.prototype.containsCoord = function(coord) {
    this.forEach(function(coord1) {
      if (coord1.x === coord.x && coord1.y === coord.y) {
        return true;
      }
    });
    return false;
  }
  
})(this);