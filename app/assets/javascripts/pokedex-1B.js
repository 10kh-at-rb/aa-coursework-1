Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $section = $("<section></section>");
  $section.addClass("detail");
  $section.html('<img src="..' + pokemon.escape("image_url") + '">');

  var $ul = $("<ul>");

  for(attribute in pokemon.attributes){
    if(attribute !== "image_url"){
      var $li = $("<li></li>");
      $li.text( attribute + ": " + pokemon.escape(attribute) );
      $ul.append($li);
    }
  }

  var $ulToys = $('<ul class="toys">');
  $ulToys.text("Toys");

  $section.append($ul).append($ulToys);

  this.$pokeDetail.html($section);

  pokemon.toys().each(function (toy) {
    this.addToyToList(toy);
  }.bind(this))
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data("id");
  var pokemon = this.pokes.get(id);
  pokemon.fetch({
    success: function() {
      this.renderPokemonDetail(pokemon);
    }.bind(this)
  });

};
