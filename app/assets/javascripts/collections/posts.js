Journal.Collections.Posts = Backbone.Collection.extend( {
  url: "/posts",

  model: Journal.Models.Post,

  getOrFetch: function(id){
    var post = this.get(id);
    var success;

    if (!post) {
      post = new Journal.Models.Post({ id: id });
      success = function () {
        this.add(post);
      }.bind(this)
    }

    post.fetch({ success: success });

    return post;
  }
});
