var TTT = require("./index");

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log(TTT.Game);
var g = new TTT.Game(reader);

g.run(function() {
  reader.close();
});
