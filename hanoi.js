var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

HanoiGame = function () {
  this.stacks = [[1, 2, 3], [], []];
};

HanoiGame.prototype.isWon = function () {
  return this.stacks[2].length === 3;
};

HanoiGame.prototype.isATower = function (tower) {
  return typeof tower === "number" && tower >= 0 && tower <= 2;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (!this.isATower(startTowerIdx) || !this.isATower(endTowerIdx)) {
    return false;
  } else {
    return this.stacks[startTowerIdx].length > 0 &&
      (this.stacks[endTowerIdx].length == 0 ||
        this.stacks[startTowerIdx][0] < this.stacks[endTowerIdx][0]);
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    var shifted = this.stacks[startTowerIdx].shift();
    this.stacks[endTowerIdx].unshift(shifted);
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Enter move: ", function(answer) {
    var move = answer.split(",");
    callback(parseInt(move[0]), parseInt(move[1]));
  });
};

HanoiGame.prototype.handleTurn = function (startTowerIdx, endTowerIdx) {
  if (this.move(startTowerIdx, endTowerIdx)) {
    if (this.isWon()) {
      this.print();
      console.log("you won");
    }
  } else {
    console.log("illegal move");
  }

  return this.isWon();
};

HanoiGame.prototype.run = function (completionCallback) {
  var game = this;
  this.promptMove(function (startTowerIdx, endTowerIdx) {
    if (game.handleTurn(startTowerIdx, endTowerIdx)) {
      completionCallback();
    } else {
      game.run(completionCallback);
    }
  });
};

hanoi = new HanoiGame();
hanoi.run(function () {
  reader.close();
});
