var sum = function () {
  var arr = Array.prototype.slice.call(arguments);
  var sum = 0;
  arr.forEach(function (el) {
    sum += el;
  });

  return sum;
};


Function.prototype.myBindWithArgs = function (obj) {
  var context = this;
  var arr = Array.prototype.slice.call(arguments, 1);

  return function () {
    return context.apply(obj, arr);
  };
};


var curriedSum = function(numArgs) {
  var numbers = [];
  var sum = 0;
  var _curriedSum = function (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      numbers.forEach(function (el) {
        sum += el;
      });
      return sum;
    }else{
      return _curriedSum;
    }
  };
  return _curriedSum;
};

Function.prototype.curry = function(numArgs){
  var context = this;
  var numbers = [];
  var _curried = function(num){
    numbers.push(num);
    if (numbers.length === numArgs){
      return context.apply(null, numbers);
    } else {
      return _curried;
    }
  };
  return _curried;
}
