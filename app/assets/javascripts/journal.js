window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');
    Journal.Models.Post = Backbone.Model.extend( { urlRoot: "/posts" } )
    Journal.Collections.Posts = Backbone.Collection.extend( {
      url: "/posts",
      model: Journal.Models.Post,
      getOrFetch: function(id){
        if (this.get(id)) {
          this.get(id).fetch();
        } else {
          var post = new Journal.Models.Post( {id:id} );
          post.fetch( { success: function(){
            this.add(post);
            console.log("success callback")
          }.bind(this) } )
        }
      }
      });
  }
};



$(document).ready(function(){
  Journal.initialize();
});
