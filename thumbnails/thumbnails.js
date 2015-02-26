$.Thumbnails = function (el) {
  this.$el = $(el);
  this.gutterIdx = 0;
  this.$images = this.$el.find('.gutter-images').children().clone();
  this.fillGutterImages();

  this.$activeImg = this.$el.find('.gutter-images').children().first();
  this.activate(this.$activeImg);

  this.$el.on("click", ".gutter-images img", this.activateNewImage.bind(this));
  this.$el.on("mouseenter", ".gutter-images img", this.mouseOverActivate.bind(this));
  this.$el.on("mouseleave", ".gutter-images img", this.mouseLeaveActivate.bind(this));
  this.$el.on("click", "a.nav", this.shiftGutterImages.bind(this));

};

$.Thumbnails.prototype.activateNewImage = function (event) {
  var $clicked = $(event.currentTarget);
  this.$activeImg = $clicked;
  this.activate($clicked);
};

$.Thumbnails.prototype.mouseOverActivate = function (event) {
  var $clicked = $(event.currentTarget);
  this.activate($clicked);
};

$.Thumbnails.prototype.mouseLeaveActivate = function (event) {
  this.activate(this.$activeImg);
}

$.Thumbnails.prototype.shiftGutterImages = function (event) {
  event.preventDefault();
  var $clicked = $(event.currentTarget);
  if ($clicked.html === "&lt;") {
    this.gutterIdx += 1;
    if (this.gutterIdx >= this.$images.length) {
      this.gutterIdx = 0;
    }
  }
  else {
    this.gutterIdx -= 1;
    if (this.gutterIdx < 0) {
      this.gutterIdx = this.$images.length - 1;
    }
  }
  this.fillGutterImages();
};

$.Thumbnails.prototype.activate = function ($img) {
  var $imgClone = $img.clone();
  this.$el.find('.active').html("");
  this.$el.find('.active').append($imgClone);
};

$.Thumbnails.prototype.fillGutterImages = function () {
  this.$el.find('.gutter-images').html("");
  for (i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
    var j = i;
    if (j > this.$images.length - 1) {
      j -= this.$images.length;
    }

    var $img = $(this.$images[j]);
    this.$el.find('.gutter-images').append($img);
  }
}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
