(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  
  var Asteroid = Asteroids.Asteroid = function(pos, vel, radius, color) {
    // this.COLOR = '#339900';
    // this.RADIUS = 5;
    Asteroids.MovingObject.call(this, pos, vel, 40, '#339900');
  };
  
  Asteroid.inherits(Asteroids.MovingObject);
  
  Asteroid.prototype.randomAsteroid = function (dimX, dimY) {
    var x = Math.floor(Math.random() * dimX);
    var y = Math.floor(Math.random() * dimY);
    var SPEED_MODIFIER = 40;
    var modX = (dimX / SPEED_MODIFIER);
    var modY = (dimY / SPEED_MODIFIER);
    var velX = Math.floor((Math.random() - 0.5) * modX);
    var velY = Math.floor((Math.random() - 0.5) * modY);
    var that = this;
    return new Asteroid([x, y], [velX, velY]);
  };
  
})(this);