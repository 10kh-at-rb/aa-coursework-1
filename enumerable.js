Array.prototype.my_each = function(funct) {
  for (var i = 0; i < this.length; i++) {
    funct(this[i]);
  }
};


Array.prototype.my_map = function(funct) {
  returnArray = [];
  for (var i = 0; i < this.length; i++) {
    returnArray.push(funct(this[i]));
  }

  return returnArray;
};
