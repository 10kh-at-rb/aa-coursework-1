Journal.Routers.postsRouter = Backbone.Router.extend ( {
  initialize: function(options) {
    this.$container = options.$container;
    this.$sidebar = this.$container.find("sidebar");
    this.$content = this.$container.find("content");
    this.posts = new Journal.Collections.Posts();
    this.postsIndex();
  },

  routes: {
    "": "postsIndex",
    "posts/new": "postNew",
    "posts/:id": "postsShow",
    "posts/:id/edit": "postEdit"

  },

  postsIndex: function () {
    var indexView = new Journal.Views.PostsIndex({collection: this.posts});
    this.posts.fetch( {
      success: function() {
        this.$sidebar.html(indexView.render().$el);
      }.bind(this)
    });
    this.$content.html("")
  },

  postsShow: function (id) {
    var post = this.posts.getOrFetch(id);

    var postView = new Journal.Views.PostShow({model: post, collection: this.posts});

    this.$content.html(postView.render().$el);
  },

  postEdit: function (id) {
    var post = this.posts.getOrFetch(id);

    var formView = new Journal.Views.PostForm({
      model: post
    });

    this.$content.html(formView.render().$el);
  },

  postNew: function () {
    console.log("postsnew")
    var post = new Journal.Models.Post();

    var formView = new Journal.Views.PostForm({
      model: post,
      collection: this.posts
    });

    this.$content.html(formView.render().$el);
  }
} )
