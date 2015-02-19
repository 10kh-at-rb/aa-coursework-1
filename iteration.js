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
