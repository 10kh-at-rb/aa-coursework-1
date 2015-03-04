Journal.Views.PostShow = Backbone.View.extend( {
  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "dblclick .editable": "editPost",
    "blur input": "savePost"
  },

  template: JST['postShow'],

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  editPost: function (event) {
    var $input = $('<input type="text">');
    $(event.currentTarget).removeClass("editable")
    $input.val($(event.currentTarget).text());
    $(event.currentTarget).html($input);
  },

  savePost: function (event) {
    var name = $(event.currentTarget).parent().attr("id")
    var value = $(event.currentTarget).val();
    var attrs = {};
    attrs[name] = value;
    this.model.save(attrs, {
      success: function() {
        this.collection.fetch();
      }.bind(this)
    });
  }
});
