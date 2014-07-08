var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var crazyBubbleSort = function(arr, sortCompletionCallback) {
    var sortPassCallback = function(swapsMade) {
        if (swapsMade) {
            performSortPass(arr, 0, false, sortPassCallback);
        } else {
            sortCompletionCallback(arr);
        }
    };
    performSortPass(arr, 0, false, sortPassCallback);
};

var performSortPass = function (arr, i, madeAnySwaps, runAnotherLoopCallback) {
    if (i < arr.length - 1) {
        askLessThan(arr[i], arr[i + 1], function (lessThan) {
            if (!lessThan) {
                var temp = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = temp;
                performSortPass(arr, i + 1, true, runAnotherLoopCallback);
            } else {
                performSortPass(arr, i + 1, madeAnySwaps, runAnotherLoopCallback);
            }
        });
    } else {
        runAnotherLoopCallback(madeAnySwaps);
    } 
};

var askLessThan = function (el1, el2, swappingCodeCallback) {
    reader.question("Is " + el1 + " less than " + el2 + "?", 
        function (yesOrNo) {
            if (yesOrNo === 'yes') {
                swappingCodeCallback(true);
            } else {
                swappingCodeCallback(false);
            }
        }
    );
};

crazyBubbleSort([3, 2, 1], function (arr) { console.log(arr); });