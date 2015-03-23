var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name;
};

var angie = new Cat("Angie", "Seth");

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
};

var raymond = new Cat("Raymond", "Deborah")

Cat.prototype.meow = function() {
  return "meow";
};

raymond.meow = function() {
  return "These pretzals are makin' me thirsty"
};
