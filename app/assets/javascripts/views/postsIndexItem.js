Journal.Views.PostsIndexItem = Backbone.View.extend( {
  initialize: function(options) {
    this.post = options.post;
  },

  events: {
    "click .delete" : "deletePost"
  },

  template: JST['indexItem'],

  render: function() {
    var content = this.template( {post: this.post} );
    this.$el.html(content);
    return this;
  },

  tagName: "li",

  deletePost: function(event) {
    this.post.destroy();
  }
});
