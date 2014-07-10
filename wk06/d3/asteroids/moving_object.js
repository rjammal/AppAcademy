

(function(root){
  
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  
  var MovingObject = Asteroids.MovingObject = function(pos, vel, radius, color){
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
  };
  
  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );
    
    ctx.fill();
  };
  
  MovingObject.prototype.isCollidedWith = function(obj) {
    var deltaX = this.pos[0] - obj.pos[0];
    var deltaY = this.pos[1] - obj.pos[1];
    var distance = Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
    return distance < (this.radius + obj.radius);
  };
  
  MovingObject.prototype.move = function (maxX, maxY) {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos[0] = (this.pos[0] < 0 ? maxX : this.pos[0] % maxX);
    this.pos[1] = (this.pos[1] < 0 ? maxY : this.pos[1] % maxY);
  };
  
})(this);