window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.router = new Journal.Routers.postsRouter({
      $container: $(".content")
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
