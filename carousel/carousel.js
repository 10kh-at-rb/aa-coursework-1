$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.find("img").first().addClass("active");
  this.$el.find("img").last().addClass("left");
  $(this.$el.find("img")[1]).addClass("right");

  $('.slide-right').on("click", this.slide.bind(this, -1));

  $('.slide-left').on("click", this.slide.bind(this, 1));
};

$.Carousel.prototype.slide = function(dir, event) {
  var carousel = this;
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;

  var $imgs = this.$el.find("img");
  var oldActiveIdx = this.activeIdx;
  var newActiveIdx = this.activeIdx + dir;

  if (newActiveIdx < 0) {
    newActiveIdx = $imgs.length - 1;
  } else if (newActiveIdx >= $imgs.length) {
    newActiveIdx = 0;
  }

  var leftIdx = (newActiveIdx === 0) ? ($imgs.length - 1) : (newActiveIdx - 1);
  var rightIdx = (newActiveIdx === $imgs.length - 1) ? (0) : (newActiveIdx + 1);
  var oldShift = (dir === -1) ? ('right') : ('left');
  var newShift = (dir === -1) ? ('left') : ('right');
  var newShiftIdx = (dir === -1) ? (leftIdx) : (rightIdx);
  $($imgs[newActiveIdx]).addClass('active');


  $($imgs).removeClass(oldShift);
  $($imgs[newActiveIdx]).removeClass(newShift);
  $($imgs[oldActiveIdx]).addClass(oldShift);
  $($imgs[newShiftIdx]).addClass(newShift);

  this.$el.one("transitionend", function (event) {
    setTimeout( function () {
      $($imgs[oldActiveIdx]).removeClass('active');
      carousel.transitioning = false;
    }, 0);
  })

  this.activeIdx = newActiveIdx;
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
