(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  var Ship = Asteroids.Ship = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel, 20, '#FF00FF');
    this.heading = 0;
    
    var img = new Image();
    var ship = this; 
    img.src = 'shipImage.gif';
    this.img = img; 
  };

  Ship.WIDTH = 40;
  Ship.HEIGHT = 40;
  
  Ship.inherits(Asteroids.MovingObject);
  
  var headingVec = function(heading){
    var x = Math.cos((heading - 90)/180 * Math.PI);
    var y = Math.sin((heading - 90)/180 * Math.PI);
    return [x,y];
  }
  
  
  Ship.prototype.power = function(impulse) {
    var headingV = headingVec(impulse);
    this.vel[0] += headingV[0];
    this.vel[1] += headingV[1]; 
  };

  Ship.prototype.move = function(dimX, dimY) {
    Asteroids.MovingObject.prototype.move.call(this, dimX, dimY);
    this.slowDown();
  }

  Ship.prototype.draw = function(ctx) {

    var xCenter = this.pos[0] - (Ship.WIDTH / 2);
    var yCenter = this.pos[1] - (Ship.HEIGHT / 2); 
    ctx.translate(this.pos[0], this.pos[1]);
    ctx.rotate(Math.PI * this.heading / 180);
    ctx.translate(this.pos[0] * -1, this.pos[1] * -1);

    ctx.drawImage(this.img, 40, 0, Ship.WIDTH, Ship.HEIGHT, xCenter, yCenter, Ship.WIDTH, Ship.HEIGHT);

    ctx.translate(this.pos[0], this.pos[1]);
    ctx.rotate(Math.PI * this.heading * -1 / 180);
    ctx.translate(this.pos[0] * -1, this.pos[1] * -1);
  }

  Ship.prototype.slowDown = function() {
    if (Math.abs(this.vel[0]) < 0.05 && Math.abs(this.vel[1]) < 0.05) {
      this.vel = [0, 0];
    } else {
      this.vel = [this.vel[0] * 0.99, this.vel[1] * 0.99];
    }
  }
  
  Ship.prototype.fireBullet = function() {
    var bulletSpeed = 10;
    var bulletVel = [headingVec(this.heading)[0]*bulletSpeed,
                     headingVec(this.heading)[1]*bulletSpeed];
    var bulletPos = [this.pos[0], this.pos[1]];
    return new Asteroids.Bullet(bulletPos, bulletVel);
  };
  
})(this);