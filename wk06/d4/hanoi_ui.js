function HanoiUI(game) {
  this.game = game;
  this.originalStack = undefined;
}

HanoiUI.prototype.setEventHandlers = function() {
  var ui = this;
  $('#stacks').on('click', '.stack', function() {
    if (typeof ui.originalStack === "undefined") {
      ui.originalStack = this;
    } else {
      var startIndex = parseInt($(ui.originalStack).attr('id'));
      var endIndex = parseInt($(this).attr('id'));
      ui.game.takeTurn(startIndex, endIndex);
      ui.createStacks($('#stacks'));
      ui.originalStack = undefined;
    };
  });
  
};



HanoiUI.prototype.createStacks = function($stacks) {
  var game = this.game;
  $stacks.empty()
  _.times(3, function(n) {
    $stacks.append("<div class='stack' id= '" + n +  "'></div>");
  });
  for (var i = 0; i < game.towers.length; i++) {
    var $tower = $('#' + i);
    $tower.empty();
    game.towers[i].forEach(function(disc) {
      $tower.prepend("<div discWidth='" + disc + "' class='disc'></div>");
    });
  }

  this.fixDiscWidth();
};

HanoiUI.prototype.fixDiscWidth = function() {
  $('.disc').each(function(index, element) {
    var id = parseInt($(element).attr('discWidth'))
    $(element).width((id * 30) + 'px');
  })
};