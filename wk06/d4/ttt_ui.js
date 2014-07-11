
function TTTUI(game) {
  this.game = game;
}

TTTUI.prototype.createGrid = function($grid) {
  _.times(9, function(n) {
    $grid.append("<div class='square' id=" + n + "></div>");
  });
};

TTTUI.prototype.setColor = function ($el) {
  if (this.game.player === 'x') {
    $el.css('background', 'red');
  } else {
    $el.css('background', 'blue');
  }
};

TTTUI.prototype.setEventHandlers = function () {
  var ui = this;
  $('#grid').on('click', '.square', function() {
    var coords = ui.getCoords($(this));
    if (ui.game.turn(coords)) {
      (ui.setColor.call(ui, $(this)));
    }
  })
};

TTTUI.prototype.getCoords = function ($square) {
  var id = parseInt($square.attr("id"));
  var col = id % 3;
  var row = Math.floor(id / 3);
  return [row, col];
};

