(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  
  var Asteroid = Asteroids.Asteroid = function(pos, vel, radius, color) {
    // this.COLOR = '#339900';
    this.radius = 40;
    this.imageHeight = 50;
    this.rotation = 0;
    this.rotateSpeed = Math.random() * 3 - 1.5;

    var img = new Image();
    img.src = 'shipImage.gif';
    this.img = img; 

    this.xImg = 0;
    this.yImg = 240;
    Asteroids.MovingObject.call(this, pos, vel, this.radius, '#339900');
  };
  
  Asteroid.inherits(Asteroids.MovingObject);

  Asteroid.prototype.move = function(dimX, dimY) {
    Asteroids.MovingObject.prototype.move.call(this, dimX, dimY);
    this.rotation += this.rotateSpeed;
  };


  
  Asteroid.prototype.draw = function(ctx) {

    var xCenter = this.pos[0] - (this.radius / 2);
    var yCenter = this.pos[1] - (this.imageHeight / 2); 
    ctx.translate(this.pos[0], this.pos[1]);
    ctx.rotate(Math.PI * this.rotation / 180);
    ctx.translate(this.pos[0] * -1, this.pos[1] * -1);

    ctx.drawImage(this.img, this.xImg, this.yImg, 60, 55, xCenter, yCenter, this.radius * 2, this.radius * 2);

    ctx.translate(this.pos[0], this.pos[1]);
    ctx.rotate(Math.PI * this.rotation * -1 / 180);
    ctx.translate(this.pos[0] * -1, this.pos[1] * -1);
  }

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