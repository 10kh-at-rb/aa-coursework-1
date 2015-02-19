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
        var pair = [i, j]
        twoSums.push(pair);
    };
  };

  return twoSums;
};
