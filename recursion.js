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
