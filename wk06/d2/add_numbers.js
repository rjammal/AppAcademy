var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, completionCallback) {
    if (numsLeft > 0) {
        reader.question("Enter a number to sum:", function (numString) {
            var num = parseInt(numString);
            sum += num;
            console.log(sum);
            numsLeft -= 1;
            addNumbers(sum, numsLeft, completionCallback);
        });
    } else {
        completionCallback(sum);
    }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});