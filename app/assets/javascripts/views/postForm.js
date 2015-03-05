Journal.Views.PostForm = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit" : "submitForm"
  },

  template: JST['post_form'],

  tagName: "form",

  render: function () {
    var content = this.template({
      post: this.model,
      errors: this.errors
    });
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();

    var attrs = $(event.currentTarget).serializeJSON().post;

    this.model.save(attrs, {
      success: function () {
        var collection = this.model.collection || this.collection;
        collection.add(this.model, {merge: true});
        Backbone.history.navigate("#posts/" + this.model.get("id"),
            {trigger: true}
        );
      }.bind(this),
      error: function (_, response) {
        this.errors = response.responseJSON;
        this.render(); // error event 
      }.bind(this)
    })
  }
});
