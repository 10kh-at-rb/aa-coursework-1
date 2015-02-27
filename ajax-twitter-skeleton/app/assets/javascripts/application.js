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
  $.FollowToggle = function (el, options) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id") || options.userId;
    this.followState = this.$el.attr("follow-state") || options.followState;
    console.log(this);
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

  $.UsersSearch = function (el) {
    this.$el = $(el);
    this.$input = this.$el.find("input");
    this.$ul = this.$el.find(".users");

    this.$input.on("input", this.handleInput.bind(this));
  };

  $.UsersSearch.prototype.handleInput = function (event) {
    var input = this.$input.serialize();

    $.ajax({
      url: "/users/search",
      type: "GET",
      data: input,
      dataType: "JSON",
      success: function (data) {
        this.listGenerate(data);
      }.bind(this)
    })
  };

  $.UsersSearch.prototype.listGenerate = function (data) {
    this.$ul.empty();
    for ( var i = 0; i < data.length; i++) {
      var entry = data[i];
      var $li = $("<li>");
      $li.append("<a href=\"users/" +
                  entry.id + "\">" +
                  entry.username + "</a>")
      var $button = $("<button>")
      new $.FollowToggle($button, {userId: entry.id, followState: entry.followed.toString()});
      $li.append($button);
      this.$ul.append($li);
    };
  };

  $.fn.followToggle = function () {
    return this.each(function () {
      new $.FollowToggle(this);
    });
  };

  $.fn.usersSearch = function () {
    return this.each(function () {
      new $.UsersSearch(this);
    });
  };
});
