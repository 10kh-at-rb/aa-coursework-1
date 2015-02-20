var b = require('./board');

function Game(reader) {
  this.reader = reader;
  this.board = new b();
}

Game.prototype.printWinner = function () {
  this.board.print();

  if (this.board.winner("X")) {
    console.log("X won");
  } else if (this.board.winner("O")){
    console.log("O won");
  } else {
    console.log("a draw");
  }
};

Game.prototype.handleTurn = function (pos, mark) {
  if (mark === "X" || mark === "O") {
    if (!this.board.placeMark(pos, mark)) {
      console.log("illegal move");
    }
  } else {
    console.log("invalid mark");
  }
};

Game.prototype.run = function(completionCallback) {
  if (this.board.gameOver()) {
    this.printWinner();
    completionCallback();
  } else {
    this.board.print();
    var game = this;

    this.reader.question("Enter a move: ", function (response) {
      var parsed = response.split(","),
          mark   = parsed[0],
          row    = parseInt(parsed[1]),
          col    = parseInt(parsed[2]);

      game.handleTurn([row, col], mark);
      game.run(completionCallback);
    });
  }
};

module.exports = Game;
