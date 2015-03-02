Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $li = $("<li></li>");
  $li.text( pokemon.get("name") + " " + pokemon.get("poke_type"));
  this.$pokeList.append($li);
  $li.addClass("poke-list-item");
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: function() {
      _.each(this.pokes.models, function(pokemon) {
        this.addPokemonToList(pokemon);
      }, this);
    }.bind(this)
  });

};
