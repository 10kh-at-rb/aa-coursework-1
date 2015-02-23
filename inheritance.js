Function.prototype.inherits = function(parent){
  function Surrogate () {};
  //var Surrogate = new function(){};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
};

var Animal = function(name){
  this.name = name;
};

Animal.prototype.wave = function(){
  console.log("waves");
};



var Cat = function(name, color){
  Animal.call(this, name);
  this.color = color;
};
Cat.inherits(Animal);

Cat.prototype.purr = function() {
  console.log("purr");
}

var Dog = function(name, age, breed){
  Animal.call(this, name);
  this.age = age;
  this.breed = breed;
};

Dog.inherits(Animal);
Dog.prototype.bark = function() {
  console.log("woof");
}

// var cat = new Cat("Ben", "green"){
//
// };
