"use strict";

Array.prototype.uniq = function () {
  var uniqs = [];

  this.forEach(function (el, i){
    if (!uniqs.includes(el)) {
      uniqs.push(el);
    }
  });

  return uniqs;
};

Array.prototype.includes = function (val) {
  var returnValue = false;
  this.forEach(function (el, i){
    if (val === el) {
      returnValue = true;
    }
  });
  return returnValue;
};


Array.prototype.twoSum = function () {
  var twoSums = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i; j < this.length; j++) {
      if (j !== i && (this[i] + this[j]) === 0) {
        var pair = [i, j];
        twoSums.push(pair);
      }
    };
  };

  return twoSums;
};

var myTranspose = function (arr) {
  var transposed = [];

  for (var index = 0; index < arr.length; index++){
    transposed.push([]);
  };

  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr.length; j++) {
      transposed[j][i] = arr[i][j];
    };
  };

  return transposed;
};


var stockPicker = function (arr) {
  var maxProfit = 0;
  var bestDates = [];

  for (var i = 0; i <= arr.length - 2; i++) {
    for (var j = i + 1; j <= arr.length - 1; j++) {
      if (arr[j] - arr[i] > maxProfit) {
        bestDates = [i, j];
        maxProfit = arr[j] - arr[i];
      }
    };
  };

  return bestDates;
};
