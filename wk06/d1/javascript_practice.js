"use strict";

Array.prototype.dups = function() {
    var unique = [];
    for (var i = 0; i < this.length; i++) {
        if (unique.indexOf(this[i]) < 0) {
            unique.push(this[i]);
        }
    }
    return unique;
};

Array.prototype.twoSum = function() {
    var indices = [];
    for (var i = 0; i < this.length - 1; i++) {
        for (var j = i + 1; j < this.length; j++) {
            if (this[i] + this[j] === 0) {
                indices.push([i, j]);
            }
        }
    }
    return indices;
};

Array.prototype.transpose = function() {
    var transposed = []; 
    //make n empty arrays
    for (var i = 0; i < this.length; i++) {
        transposed.push([]);
    }
    //iterate through rows
    for (var row = 0; row < this.length; row++) {
        for (var col = 0; col < this.length; col++) {
            transposed[col].push(this[row][col]);
        }
    }
    return transposed;
};

Array.prototype.multiples = function() {
    var result = [];
    for (var i = 0; i < this.length; i++) {
        result.push(this[i] * 2);
    }
    return result;
};

Array.prototype.each = function(func) {
    for (var i = 0; i < this.length; i++) {
        func(this[i]);
    }
    return this;
};

Array.prototype.map = function(func) {
    var result = [];
    this.each(function(elem) {
        result.push(func(elem));
    });
    return result;
};

Array.prototype.inject = function(func) {
    var accumulator = this[0];
    var first = true;
    this.each(function(elem) {
        if (first) {
            first = false;
        } else {
            accumulator = func(accumulator, elem);
        }
    });
    return accumulator;
};

Array.prototype.bubbleSort = function() {
    var sorted = false;
    do {
        sorted = true;
        for (var i = 0; i < this.length - 1; i++) {
            if (this[i] > this[i+1]) {
                sorted = false;
                var newI = this[i];
                this[i] = this[i+1];
                this[i+1] = newI;
            }
        }
    } while (!sorted);
    return this;
};

String.prototype.substrings = function () {
    var subs = [];
    for (var i = 0; i < this.length; i++) {
        for (var j = i + 1; j < this.length + 1; j++) {
            subs.push(this.slice(i, j));
        }
    }
    return subs.dups();
};

var range = function (start, end) {
    if (start >= end) {
        return [];
    } else {
        var result = range(start, end - 1);
        result.push(end - 1);
        return result;
    }
};

var exponent1 = function (base, power) {
    if (power === 0) {
        return 1;
    } else {
        return base * exponent1(base, power - 1);
    }
};

var exponent2 = function (base, power) {
    if (power === 0) {
        return 1;
    } else if (power % 2 === 1) {
        return base * exponent2(base, power - 1);
    } else {
        var squareRoot = exponent2(base, power / 2);
        return squareRoot * squareRoot;
    }
};

var fibonacci = function(n) {
    if (n === 1) {
        return [1];
    } else if (n === 2) {
        return [1, 1];
    } else {
        var result = fibonacci(n - 1);
        var next = result[result.length - 1] + result[result.length - 2];
        result.push(next);
        return result;
    }
};

var binarySearch = function(array, target) {
    if (array.length === 0) {
        return -1;
    } else {
        var middle = Math.floor(array.length/2);
        if (array[middle] === target) {
            return middle;
        } else if (target < array[middle]) {
            return binarySearch(array.slice(0, middle), target);
        } else {
            var rightResult = binarySearch(array.slice(middle), target)
            return rightResult === -1 ? -1 : rightResult + middle;
        }
    }
};

var makeChange = function(amount, denoms) {
    if (amount === 0) {
        return [];
    } else if (denoms[denoms.length-1] > amount) {
        return null;
    }
    
    var bestChange = null;
    for (var i = 0; i < denoms.length; i++) {
        if (denoms[i] <= amount) {
            var remainder = amount - denoms[i];
            var bestRemainder = makeChange(remainder, denoms.slice(i));
            if (bestRemainder === null) {
                continue;
            }
            bestRemainder.push(denoms[i]);
            var thisChange = bestRemainder;
            if (bestChange === null || thisChange.length < bestChange.length) {
                bestChange = thisChange;
            }
        } 
    } 
    return bestChange;
};

var mergeSort = function (arr) {
    if (arr.length <= 1) {
        return arr;
    }
    
    var middle = Math.floor(arr.length/2);
    var left = arr.slice(0, middle);
    var right = arr.slice(middle);
    
    left = mergeSort(left);
    right = mergeSort(right);
    
    return merge(left, right);
    
};

var merge = function (left, right) {
    var leftIndex = 0;
    var rightIndex = 0;
    var result = [];
    while (leftIndex < left.length && rightIndex < right.length) {
        if (left[leftIndex] <= right[rightIndex]) {
            result.push(left[leftIndex++]);
        } else {
            result.push(right[rightIndex++]);
        }
    }
    result = result.concat(left.slice(leftIndex));
    result = result.concat(right.slice(rightIndex));
    return result;
};

var subsets = function (array) {
    if (array.length === 0) {
        return [[]];
    }
    var subs = subsets(array.slice(0, array.length - 1));
    var result = subs.slice(0);
    for (var i = 0; i < subs.length; i++) {
        result.push(subs[i].concat([array[array.length - 1]]));
    }
    
    return result;
};