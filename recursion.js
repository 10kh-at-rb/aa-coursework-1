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

// var makeChange = function(purse, denoms) {
//   if (denoms.length === 0) {
//     return [];
//   }
//
//   var changeArr = [];
//   var testPurse = 0;
//   var i = 0;
//
//   while (testPurse < purse){
//     coin = denoms[i];
//
//     if (testPurse + coin <= purse) {
//       testPurse += coin;
//       changeArr.push(coin);
//     } else {
//       i++;
//     }
//
//     console.log(testPurse)
//     console.log(changeArr)
//   };
//
//   var lastChange = makeChange(purse, denoms.slice[1,denoms.length]);
//   if (lastChange.length < changeArr.length) {
//     return lastChange;
//     }
//     else{
//       return changeArr;
//     }
// };


var makeChange = function(purse, denoms) {
  "use strict";
  if (purse === 0) {
    return [];
  }

  var bestChange = null;

  denoms.forEach (function(coin, i) {
    if (purse < coin) { return };

    var remainder = purse - coin;
    var changeArr = [coin];
    var remainderChangeArr = makeChange(remainder, denoms.slice(i));

    changeArr = changeArr.concat(remainderChangeArr);

    if (bestChange === null || changeArr.length < bestChange.length) {
      bestChange = changeArr;
    }

  });
  // console.log(bestChange);
  return bestChange;
};

var mergeSort = function(arr) {

}

var merge = function(arr1, arr2) {
  var mergedArr = [];
  while ( arr1.length > 0 && arr2.length > 0) {
    if (arr1[0] > arr2[0]) {
      var shifted = arr2.shift();
      mergedArr.push(shifted);
    } else {
      var shifted = arr1.shift();
      mergedArr.push(shifted);
    }
    console.log("Arr1 " + arr1);
    console.log("Arr2 " + arr2);
  }

  return mergedArr.concat(arr1, arr2);
}
