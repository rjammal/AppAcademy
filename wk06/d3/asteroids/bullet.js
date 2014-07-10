(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});  
  
  var Bullet = Asteroids.Bullet = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel, 5, '#FF00FF');
    this.lifespan = 40;
  };
  
  Bullet.inherits(Asteroids.MovingObject);
  
  Bullet.prototype.move = function(x, y) {
    var bullet = this;
    Asteroids.MovingObject.prototype.move.call(bullet, x, y);
    this.lifespan -= 1;
  };
  
})(this);
  