Array.prototype.myEach = function(funct) {
  for (var i = 0; i < this.length; i++) {
    funct(this[i]);
  }
};


Array.prototype.myMap = function(funct) {
  var returnArray = [];

  var createMap = function(num){
    returnArray.push(funct(num));
  };

  this.myEach(createMap);

  return returnArray;
};

Array.prototype.inject = function(funct) {
  var start = this.shift();
  var accum = start;

  var createInjection = function(num){
    if (accum = funct(accum, num));
  };

  this.myEach(createInjection);

  this.unshift(start);
  return accum;
};
