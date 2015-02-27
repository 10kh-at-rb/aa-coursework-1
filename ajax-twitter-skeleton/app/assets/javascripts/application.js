// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(function () {
  $.FollowToggle = function (el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.attr("follow-state");
    this.render();
    this.$el.on("click", this.handleClick.bind(this));
  };

  $.FollowToggle.prototype.render = function () {
    if (this.followState === "true") {
      this.$el.text("Unfollow!");
    } else if (this.followState === "false"){
      this.$el.text("Follow!" );
    }
  };

  $.FollowToggle.prototype.handleClick = function (event) {
    event.preventDefault();

    if (this.followState === "true") {
      var method = "DELETE";
    } else if (this.followState === "false") {
      var method = "POST";
    }

    this.$el.prop('disabled', true);
    $.ajax({
      url: ("/users/" + this.userId + "/follow"),
      type: method,
      success: function () {
        this.followState = (method === "POST") ? "true" : "false";
        this.render();
        this.$el.prop('disabled', false);
      }.bind(this),
      dataType: "JSON"
    })
  };

  $.fn.followToggle = function () {
    return this.each(function () {
      new $.FollowToggle(this);
    });
  };
});

$(function () {
  $("button.follow-toggle").followToggle();
});
