Function.prototype.myBind = function (object) {
    var that = this;
    return function () {
        that.apply(object, []);
    };
};

function Cat(name) {
    this.name = name;
    this.meow = function() {
        console.log(this.name + " meow");
    };
}

var c = new Cat("Gizmo");

var f = c.meow;
var g = f.myBind(c);
g();