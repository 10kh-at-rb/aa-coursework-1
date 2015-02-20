var b = require('./board');

function Game(reader) {
  this.reader = reader;
  this.board = new b();
  this.turn = "X";
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

Game.prototype.handleTurn = function (pos) {
  if (this.board.placeMark(pos, this.turn)) {
    this.turn === "X" ? this.turn = "O" : this.turn = "X";
  } else {
    console.log("illegal move");
  }
};

Game.prototype.run = function(completionCallback) {
  if (this.board.gameOver()) {
    this.printWinner();
    completionCallback();
  } else {
    this.board.print();

    this.reader.question(this.turn + ", enter a move: ", function (response) {
      var parsed = response.split(","),
          row    = parseInt(parsed[0]),
          col    = parseInt(parsed[1]);

      this.handleTurn([row, col]);
      this.run(completionCallback);
    }.bind(this));
  }
};

module.exports = Game;
