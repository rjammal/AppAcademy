(function (root) {
  var SnakeGame = root.SnakeGame = (root.SnakeGame || {});

  var Coord = SnakeGame.Coord = function(x, y) {
    this.x = x;
    this.y = y;
  }
  
  Coord.prototype.plus = function(dir) {
    var result = new Coord(this.x, this.y);
    switch (dir) {
    case "W":
      result.x -= 1;
      break;
    case 'E':
      result.x += 1;
      break;
    case 'S': 
      result.y += 1;
      break;
    case 'N':
      result.y -= 1; 
      break;
    default:
    }
    if (result.inBounds()) {
      return result;
    } else {
      alert("You lose, loser.");
      throw "Loser";
    }
  }
  
  Coord.prototype.inBounds = function() {
    return this.x >= 0 && this.x <= 500 && this.y >= 0 && this.y <= 500;
  }

  var Snake = SnakeGame.Snake = function (coord) {
    this.dir = 'W';
    this.segment = [coord];
  }
  
  Snake.prototype.move = function(newHead, applePresent) {    
  
    if (applePresent) {
      this.segment = [newHead].concat(this.segment);
    } else {
     this.segment = [newHead].concat(this.segment.slice(0, this.segment.length - 1)); 
    }
  }
  
  Snake.prototype.turn = function(dir) {
    this.dir = dir;
  }
  
})(this);