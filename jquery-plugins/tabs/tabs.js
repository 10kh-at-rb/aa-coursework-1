$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr('data-content-tabs'));
  this.$activeTab = this.$contentTabs.find('.active');

  this.$el.on('click', 'a', function (event) {
      this.clickTab(event);
  }.bind(this));

};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$el.find('a').removeClass('active');
  this.$activeTab.addClass('transitioning');

  var $clicked = $(event.currentTarget);
  $clicked.addClass('active');

  this.$activeTab.one('transitionend', function (event) {
    this.$activeTab.removeClass('active');
    this.$activeTab.removeClass('transitioning');
    this.$activeTab = this.$contentTabs.find($clicked.attr("href"));
    this.$activeTab.addClass('transitioning');
    this.$activeTab.addClass('active');
    var $activeTab = this.$activeTab;
    setTimeout(function () {
      $activeTab.removeClass('transitioning');
    }, 0);

  }.bind(this));

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
