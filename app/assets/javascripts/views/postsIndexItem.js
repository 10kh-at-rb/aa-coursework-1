Journal.Views.PostsIndexItem = Backbone.View.extend( {
  initialize: function(options) {
    this.post = options.post;
    if (this.post.id === 19) console.log("index item", this.post)
    this.listenTo(this.post, "change", this.render);
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
    Backbone.history.navigate("", {trigger: true});
  }
});
