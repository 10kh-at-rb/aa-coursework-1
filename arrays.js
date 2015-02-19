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
