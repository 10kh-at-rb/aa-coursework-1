var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function(number) {
      sum += parseInt(number);
      console.log("running total ", sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });

  } else {
    reader.close();
    completionCallback(sum);
  }
};

addNumbers(0, 3, function(sum) {
  console.log(sum);
})
