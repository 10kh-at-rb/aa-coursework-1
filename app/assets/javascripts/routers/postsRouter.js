Journal.Routers.postsRouter = Backbone.Router.extend ( {
  initialize: function(options) {
    this.$container = options.$container;
    this.posts = new Journal.Collections.Posts();
  },

  routes: {
    "": "postsIndex",
    "posts/:id": "postsShow",
    "posts/:id/edit": "postEdit"
  },

  postsIndex: function () {
    var indexView = new Journal.Views.PostsIndex({collection: this.posts});
    this.posts.fetch( {
      success: function() {
        this.$container.html(indexView.render().$el);
      }.bind(this)
    });
  },

  postsShow: function (id) {
    var post = this.posts.getOrFetch(id);

    var postView = new Journal.Views.PostShow({model: post});

    this.$container.html(postView.render().$el);
  },

  postEdit: function (id) {
    var post = this.posts.getOrFetch(id);

    var formView = new Journal.Views.PostForm({model: post});

    this.$container.html(formView.render().$el);
  }
} )
