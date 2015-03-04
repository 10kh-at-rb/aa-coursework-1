Journal.Views.PostsIndex = Backbone.View.extend( {
  initialize: function() {
    this.listenTo(this.collection, "remove sync", this.render);
  },

  template: JST['index'],
  render: function() {
    var content = this.template();
    this.$el.html(content);
    var $ul = this.$el.find('ul');
    this.collection.each(function (post) {
      var item = new Journal.Views.PostsIndexItem({post: post});

      $ul.append(item.render().$el);
    });
    return this;
  }
});
