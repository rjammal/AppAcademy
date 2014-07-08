var startTime = new Date();



function Clock(startTime) {
    var time = startTime;
    this.hours = time.getHours();
    this.minutes = time.getMinutes();
    this.seconds = time.getSeconds();
}

Clock.prototype.tick = function () {
    this.seconds += 5;
    if (this.seconds >= 60) {
        this.minutes += 1;
        this.seconds = this.seconds % 60;
    }
    if (this.minutes >= 60) {
        this.hours += 1;
        this.minutes = this.minutes % 60;
    }
    console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

Clock.prototype.run = function () {
    var clock = this;
    setInterval( this.tick.bind(clock), 5 * 1000 );
};

var c = new Clock(startTime);
c.run();