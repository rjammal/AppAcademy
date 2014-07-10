var sum = function() {
  var args = Array.prototype.slice.call(arguments);
  var result = 0;
  args.forEach(function(num) {
    result += num;
  });
  return result;
};

// console.log(sum(1,2,3,4));

Function.prototype.myBind = function(context) {
  var that = this; 
  return function() {
    return that.apply(context, arguments);
  };
};

function Dog(name) {
  this.name = name;
}

var d = new Dog("doug");

var bark = function () {
  return this.name + " says bark";
};

var boundBark = bark.myBind(d);

// console.log(bark());
// console.log(boundBark());


var curriedSum = function(numArgs) {
  var numbers = [];
  var _curriedSum = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      var sum = 0;
      numbers.forEach(function(el){
        sum += el;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};

Function.prototype.curry = function (numArgs) {
  var originalFunction = this;
  var args = [];
  var _curry = function(arg) {
    args.push(arg);
    if(args.length === numArgs){
      return originalFunction.apply(this, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};


console.log(sum.curry(3)(1)(5)(17));



