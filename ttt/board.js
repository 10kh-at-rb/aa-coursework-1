function Board () {
  this.grid = [
    [Board.EMPTY, Board.EMPTY, Board.EMPTY],
    [Board.EMPTY, Board.EMPTY, Board.EMPTY],
    [Board.EMPTY, Board.EMPTY, Board.EMPTY]
  ]
};

Board.EMPTY = null;
Board.O     = "O";
Board.X     = "X";

Board.prototype.print = function () {
  this.grid.forEach(function (row) {
    console.log(JSON.stringify(row));
  });
};

Board.prototype.won = function () {
  return this.winner("O") || this.winner("X");
};

Board.prototype.gameOver = function () {
  return this.won() || this.tie();
}

Board.prototype.tie = function () {
  var emptyPos = false;

  this.grid.forEach(function (row) {
    emptyPos = emptyPos || row.indexOf(Board.EMPTY) !== -1;
  });

  return !emptyPos;
}

Board.prototype.winningString = function (mark, string) {
  var threeInARow = mark + mark + mark;
  return string === threeInARow;
}

Board.prototype.rowWinner = function (mark) {
  var markWinner = false;

  this.grid.forEach(function (row) {
    markWinner = markWinner || this.winningString(mark, row.join(""));
  }, this);
  return markWinner;
};

Board.prototype.colWinner = function (mark) {
  for (var col = 0; col < 3; col++) {
    var column = this.grid[0][col] + this.grid[1][col] + this.grid[2][col];
    if (this.winningString(mark, column)) {
      return true;
    };
  }
  return false;
};

Board.prototype.diagWinner = function (mark){
  var leftDiag = this.grid[0][0] + this.grid[1][1] + this.grid[2][2];
  var rightDiag = this.grid[0][2] + this.grid[1][1] + this.grid[2][0];

  return this.winningString(mark, leftDiag) ||
      this.winningString(mark, rightDiag);
};

Board.prototype.winner = function (mark) {
  // check for a row winner
  return this.rowWinner(mark) || this.colWinner(mark) || this.diagWinner(mark);
};

Board.prototype.empty = function (pos) {
  var row = pos[0],
      col = pos[1];

  return this.grid[row][col] === Board.EMPTY;
};

Board.prototype.validPosition = function (row, col) {
  return typeof row === "number" && row >= 0 && row <= 2 &&
    typeof col === "number" && col >= 0 && col <= 2;
}

Board.prototype.placeMark = function (pos, mark) {
  var row = pos[0],
      col = pos[1];
  if (this.validPosition(row, col) && this.empty(pos)) {
    this.grid[row][col] = mark;
    return true;
  } else {
    return false;
  }
};

module.exports = Board;
