var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askIfGreaterThan = function (el1, el2, callback) {
  reader.question(el1 +">" +el2 +"?", function (answer) {
    callback(answer === "yes");
  });
};

var innerBubbleSortLoop =
    function (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
      if (isGreaterThan) {
        var temp   = arr[i];
        arr[i]     = arr[i + 1];
        arr[i + 1] = temp;

        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

var absurdBubbleSort = function (arr, sortCompletionCallBack) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallBack(arr);
    }
  }
  outerBubbleSortLoop(true);

}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});


// askIfGreaterThan(4,3, function (response) {
//   console.log(response)
// });
