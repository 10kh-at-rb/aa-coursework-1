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
