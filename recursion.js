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
