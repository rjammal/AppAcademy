(function (root) {
    var Hanoi = root.Hanoi = (root.Hanoi || {});
    var readline = require('readline');
    var reader = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
    
    var Game = Hanoi.Game = function(){
      this.pegs = [[3, 2, 1], [], []];
    };
    
    Game.prototype.run = function (completionCallback) {
        this.performDiscMove(false, completionCallback);
    };
    
    Game.prototype.performDiscMove = function (won, completionCallback) {
        if (!won) {
            this.getUserInput(function (fromMove, toMove) {
               if (this.validateMove(fromMove, toMove)) {
                   var poppedDisc = this.pegs[fromMove].pop();
                   this.pegs[toMove].push(poppedDisc);
                   won = this.winning();
               }
               console.log(this.pegs);
               this.performDiscMove(won, completionCallback);
            });
        } else {
            completionCallback();
        }
    };
    
    Game.prototype.getUserInput = function (discMovingCallback) {
        var that = this;
        reader.question("Where do you want to move from?", function(fromMove) {
            reader.question("Where do you want to move to?", function(toMove) {
               discMovingCallback.call(that, fromMove, toMove); 
            });
        });
    };
    
    Game.prototype.validateMove = function(fromPeg, toPeg) {
        if (parseInt(fromPeg) > 2 || parseInt(fromPeg) < 0) {
            console.log("From peg out of bounds. Please try again.");
            return false;
        }
        if (parseInt(toPeg) > 2 || parseInt(toPeg) < 0) {
            console.log("To peg out of bounds. Please try again.");
            return false;
        }
        if (this.pegs[fromPeg].length === 0) {
            console.log("The from peg is empty. Please try again.");
            return false;
        }
        if (this.pegs[toPeg].length === 0) {
            return true;
        }
        if (this.pegs[fromPeg][0] > this.pegs[toPeg][0]) {
            console.log("Can't move larger peg onto smaller peg. Please try again.");
            return false;
        }
        return true;
    };
    
    Game.prototype.winning = function() {
        return this.pegs[2].length === 3;
    };
    
})(this);

var game = new this.Hanoi.Game();
game.run(function () { console.log("Congratulations!") } );
