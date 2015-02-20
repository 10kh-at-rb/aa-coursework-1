function Board () {
  this.grid = [
    [Board.EMPTY, Board.EMPTY, Board.EMPTY],
    [Board.EMPTY, Board.EMPTY, Board.EMPTY],
    [Board.EMPTY, Board.EMPTY, Board.EMPTY]
  ]
};

Board.EMPTY = " ";
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

Board.prototype.winner = function (mark) {
  var markWinner = false;
  var threeInARow = mark + mark + mark;

  // check for a row winner
  this.grid.forEach(function (row) {
    markWinner = markWinner || row.join("") === threeInARow;
  });

  // check for a column winner
  for (var col = 0; col < 3; col++) {
    var column = this.grid[0][col] + this.grid[1][col] + this.grid[2][col];
    markWinner = markWinner || column === threeInARow;
  }

  var diagonal = this.grid[0][0] + this.grid[1][1] + this.grid[2][2];
  markWinner = markWinner || diagonal === threeInARow;

  diagonal = this.grid[0][2] + this.grid[1][1] + this.grid[2][0];
  markWinner = markWinner || diagonal === threeInARow;

  return markWinner;
};

Board.prototype.empty = function (pos) {
  var row = pos[0];
  var col = pos[1];

  return this.grid[row][col] === Board.EMPTY;
};

Board.prototype.placeMark = function (pos, mark) {
  var row = pos[0];
  var col = pos[1];
  if (this.empty(pos)) {
    this.grid[row][col] = mark;
    return true;
  } else {
    return false;
  }
};
