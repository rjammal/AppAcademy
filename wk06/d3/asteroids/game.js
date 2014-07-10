(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  var Game = Asteroids.Game = function (ctx) {
    this.FPS = 30;
    this.DIM_X = 800;
    this.DIM_Y = 600;
    this.ctx = ctx;
    this.asteroids = [];
    this.addAsteroids(5);
    this.ship = new Asteroids.Ship([this.DIM_X / 2, this.DIM_Y / 2], [0, 0]);
    this.bullets = [];
    
    var img = new Image();
    var game = this;
    img.onload = function () {
      game.ctx.drawImage(img, 0, 0);
    };
    img.src = 'myImage.jpg';
    this.img = img;
  };
  
  Game.prototype.addAsteroids = function(num){
    for(var i = 0; i < num; i++){
      this.asteroids.push(Asteroids.Asteroid.prototype.randomAsteroid(this.DIM_X, this.DIM_Y));
    }
  };
  
  Game.prototype.bindKeyHandlers = function() {
    var game = this;
    var turnSpeed = 15;
    key('up', function(){game.ship.power(game.ship.heading);});
    key('space', function() { game.bullets.push(game.ship.fireBullet()); });
    key('right', function() { game.ship.heading += turnSpeed;});
    key('left', function() { game.ship.heading -= turnSpeed;});
  };
  
  Game.prototype.checkCollisions = function() {
    var gameInstance = this;
    var destroyBullets = [];
    var destroyAsteroids = [];
    this.asteroids.forEach(function(asteroid) {
      if (asteroid.isCollidedWith(gameInstance.ship)) {
        alert("game over");
        clearInterval(gameInstance.timerId);
      }
      gameInstance.bullets.forEach(function(bullet) {
        if (bullet.isCollidedWith(asteroid)) {
          destroyBullets.push(bullet);
          destroyAsteroids.push(asteroid);
        } 
      });
    });
    this.bullets.forEach(function(bullet) {
      if (bullet.lifespan <= 0) {
        destroyBullets.push(bullet);
      }
    });
    destroyBullets.forEach(function(bullet) {
      var index = gameInstance.bullets.indexOf(bullet);
      gameInstance.bullets.splice(index, index + 1);
    });
    destroyAsteroids.forEach(function(asteroid) {
      var index = gameInstance.asteroids.indexOf(asteroid);
      gameInstance.asteroids.splice(index, index + 1);
    });
  };
  
  Game.prototype.draw = function() {
    this.ctx.drawImage(this.img, 0, 0);
    var gameInstance = this;
    //this.ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    this.asteroids.forEach(function(asteroid) {
      asteroid.draw(gameInstance.ctx);
    });
    this.ship.draw(this.ctx);
    this.bullets.forEach(function(bullet) {
      bullet.draw(gameInstance.ctx);
    });
  };
  
  Game.prototype.move = function() {
    var game = this;
    this.asteroids.forEach(function(asteroid) {
      asteroid.move(game.DIM_X, game.DIM_Y);
    });
    this.ship.move(game.DIM_X, game.DIM_Y);
    this.bullets.forEach(function(bullet) {
      bullet.move(game.DIM_X, game.DIM_Y);
    });
  };
  
  Game.prototype.step = function() {
    this.move();
    this.draw();
    this.checkCollisions();
  };
  
  Game.prototype.start = function() {
    this.bindKeyHandlers();
    var game = this;
    this.timerId = window.setInterval(function() {game.step();}, game.FPS);
  };
  
})(this);