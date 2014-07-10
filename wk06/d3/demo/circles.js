(function (root) {
  var Circles = root.Circles = (root.Circles || {});

  var Circle = Circles.Circle = function (centerX, centerY, radius) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.radius = radius;
  };

  Circle.MAX_RADIUS = 25;

  Circle.randomCircle = function (maxX, maxY) {
    return new Circle(
      maxX * Math.random(),
      maxY * Math.random(),
      Circle.MAX_RADIUS * Math.random()
    );
  };

  Circle.prototype.moveRandom = function (maxX, maxY) {
    var dx = (Math.random() * 2) - 1;
    var dy = (Math.random() * 2) - 1;

    this.centerX = Math.abs((this.centerX + (dx * this.radius / this.radius)) % maxX);
    this.centerY = Math.abs((this.centerY + (dy * this.radius / this.radius)) % maxY);
  };

  Circle.prototype.render = function (ctx) {
    ctx.fillStyle = "black";
    ctx.beginPath();

    ctx.arc(
      this.centerX,
      this.centerY,
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  };

  var Game = Circles.Game = function (xDim, yDim, numCircles) {
    this.xDim = xDim;
    this.yDim = yDim;

    this.circles = []
    for (var i = 0; i < numCircles; ++i) {
      this.circles.push(Circle.randomCircle(xDim, yDim));
    }
  }

  Game.prototype.render = function (ctx) {
    ctx.clearRect(0, 0, this.xDim, this.yDim);

    this.circles.forEach(function (circle) {
      circle.render(ctx);
    });
  };

  Game.prototype.moveCircles = function () {
    var game = this;
    this.circles.forEach(function (circle) {
      circle.moveRandom(game.xDim, game.yDim);
    });
  };

  Game.prototype.start = function (canvasEl) {
    // get a 2d canvas drawing context. The canvas API lets us call
    // a `getContext` method on a canvas DOM element.
    var ctx = canvasEl.getContext("2d");

    // render at 10 FPS
    var game = this;
    window.setInterval(function () {
      game.moveCircles();
      game.render(ctx);
    }, 10);
  };
})(this);