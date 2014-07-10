(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  
  var Ship = Asteroids.Ship = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel, 20, '#FF00FF');
    this.heading = 0;
  };
  
  Ship.inherits(Asteroids.MovingObject);
  
  var headingVec = function(heading){
    var x = Math.cos(heading/180 * Math.PI);
    var y = Math.sin(heading/180 * Math.PI);
    return [x,y];
  }
  
  
  Ship.prototype.power = function(impulse) {
    var headingV = headingVec(impulse);
    this.vel[0] += headingV[0];
    this.vel[1] += headingV[1]; 
  };
  
  Ship.prototype.fireBullet = function() {
    var bulletSpeed = 10;
    var bulletVel = [headingVec(this.heading)[0]*bulletSpeed,
                     headingVec(this.heading)[1]*bulletSpeed];
    var bulletPos = [this.pos[0], this.pos[1]];
    return new Asteroids.Bullet(bulletPos, bulletVel);
  };
  
})(this);