(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.container = $el;

    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    $(".grid").on("click", "li", function(event){
      var $square = $(event.target);

      this.makeMove($square);
    }.bind(this));
  };

  View.prototype.makeMove = function ($square) {
    if ($square.hasClass("x") || $square.hasClass("o")) {
      alert("Invalid Move");
    } else {
      var pos = [$square.attr("row"), $square.attr("col")];

      $square.addClass(this.game.currentPlayer);
      this.game.playMove(pos);
    }

    if (this.game.isOver()) {
      var $grid = $('.grid');
      $grid.addClass(this.game.winner());
      $grid.addClass("over");

      $('.grid').off("click");
    }
  };

  View.prototype.setupBoard = function () {
    var i,
      $li,
      $grid = $("<ul></ul>");

    $grid.addClass("grid");

    for (i = 0; i < 3; i++) {
      for (j = 0; j < 3; j++) {
        $li = $("<li></li>");

        $grid.append($li);
        $li.attr("row", i);
        $li.attr("col", j);
      }
    }
    this.container.append($grid);

  };
})();
