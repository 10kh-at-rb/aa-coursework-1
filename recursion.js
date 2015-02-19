var range = function(start, end) {
  if (end - 1 <= start) {
    return [];
  } else {
    var nextLast = end - 1;
    // var rangeArr = [];

    var nextRange = range(start, nextLast);
    // nextLast = [nextLast].unshift(nextRange);
  }
    nextRange.push(end - 1);
    return nextRange;
};

var recursion1 = function (base, exp) {
  if (exp === 0) {
    return 1;
  } else {
    return base * recursion1(base, exp - 1);
  }
}


var recursion2 = function (base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else {
    var newExp = (exp - exp % 2) / 2;
    return recursion2(base, exp % 2) *
           recursion2(base, newExp) *
           recursion2(base, newExp);
  }
};

var fibonacci = function (n) {
  if (n === 0){
    return [];
  } else if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  }
  var fibs = fibonacci(n-1);
  var fibsLength = fibs.length;
  var nextLast = fibs[fibsLength-1] + fibs[fibsLength - 2];

  fibs.push(nextLast);
  return fibs
};

var bsearch = function (arr, target) {
  var mid = Math.floor(arr.length / 2);
  if (arr[mid] === target) {
    return mid;
  } else if (arr[mid] < target) {
    var secondHalf = arr.slice(mid + 1, arr.length);
    return bsearch(secondHalf, target) + mid + 1; //[1,2,3,4,5]
  } else if (arr[mid] > target) {
    var firstHalf = arr.slice(0, mid);
    return bsearch(firstHalf, target);
  } else {
    return null;
  }
};
