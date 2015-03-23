Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>");
  $li.data("toy-id", toy.id);
  $li.data("pokemon-id", toy.get("pokemon_id"));
  console.log($li.data());
  $li.text("name: " + toy.get("name") + ", happiness:" + toy.get("happiness") +
        ", price: " + toy.get("price"));

  this.$pokeDetail.find(".toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $detail = $('<ul class="detail">');
  var $imgLi = $("<li>");

  $imgLi.html('<img src="' + toy.escape("image_url") + '">');
  $detail.append($imgLi);

  for(attribute in toy.attributes){
    if(attribute !== "image_url") {
      var $toyAttribute = $("<li>");
      if(attribute === "pokemon_id"){
        var $select = $('<select class="pokemon-dropdown">');
        $select.data("toy-id", toy.id);
        $select.data("pokemon-id", toy.get("pokemon_id"));
        this.pokes.each(function(pokemon) {
          var $option = $('<option>');
          $option.attr("value", pokemon.id);
          if (pokemon.id === toy.get("pokemon_id")) {
            $option.attr('selected', 'selected');
          }
          $option.text(pokemon.get("name"));
          $select.append($option);
        }.bind(this))
        $toyAttribute.append($select);
      } else {
        $toyAttribute.text( attribute + ": " + toy.escape(attribute) );
      }

      $detail.append($toyAttribute);
    }
  }

  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  console.log('clicked');
  var pokemonId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  this.renderToyDetail(this.pokes.get(pokemonId).toys().get(toyId));
};
