Function.prototype.myBind = function (context) {
  var fn = this;
  return function() {
    return fn.apply(context);
  };
}

Cat = function (name) {
  this.name = name;
}

Cat.prototype.sayHi = function () {
  return "hi I'm " + this.name;
}

sennacy = new Cat("sennacy");
// console.log(Cat.prototype.sayHi());
// console.log(Cat.prototype.sayHi.bind(sennacy)());

console.log(Cat.prototype.sayHi.myBind(sennacy)());
