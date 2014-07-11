function SnakeUI() {
  this.board = new SnakeGame.Board();
}

SnakeUI.prototype.start() {
  var ui = this
  var stop = setInterval(function() {
    
    ui.board.moveSnake()
  })
}

function View($el) {
  this.$el = $el;
  
}