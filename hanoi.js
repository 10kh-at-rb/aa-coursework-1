var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

HanoiGame = function () {
  this.stacks = [[1, 2, 3], [], []];
}

HanoiGame.prototype.isWon = function () {
  return this.stacks[2].length === 3;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  return this.stacks[startTowerIdx].length > 0 &&
    (this.stacks[endTowerIdx].length == 0 ||
      this.stacks[startTowerIdx][0] < this.stacks[endTowerIdx][0]);
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    var shifted = this.stacks[startTowerIdx].shift();
    this.stacks[endTowerIdx].unshift(shifted);
    return true;
  } else {
    return false;
  }
}

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Enter move: ", function(answer) {
    var move = answer.split(",");
    callback(parseInt(move[0]), parseInt(move[1]));
  });
}

HanoiGame.prototype.run = function (completionCallback) {
  var game = this;
  this.promptMove(function (startTowerIdx, endTowerIdx) {
    if (game.move(startTowerIdx, endTowerIdx)) {
      if (game.isWon()) {
        game.print();
        console.log("you won");
        completionCallback();
      } else {
        game.run(completionCallback);
      }
    } else {
      console.log("illegal move");
      game.run(completionCallback);
    }
  });
}

hanoi = new HanoiGame();
hanoi.run(function () {
  reader.close();
});
