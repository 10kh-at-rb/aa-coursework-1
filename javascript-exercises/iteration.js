var bubbleSort = function (arr) {
  var notSorted = true
  while (notSorted) {
    notSorted = false;
    for (var i = 0; i <= arr.length-2; i++) {
      var j = i+1;
      if (arr[j] < arr[i]) {
        var temp = arr[j];
        arr[j] = arr[i];
        arr[i] = temp;
        notSorted = true;
      }
    };
  }

  return arr
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

var substrings = function (string) {
  var substringsArr = [];

  for (var i = 0; i < string.length; i++) {
    for (var j = i + 1; j <= string.length; j++) {
      var sub = string.substr(i, j - i);
      if (!substringsArr.includes(sub)) {
        substringsArr.push(sub);
      }
    };
  };

  return substringsArr;
};
