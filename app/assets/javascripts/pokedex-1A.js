Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>");
  $li.text( pokemon.get("name") + " " + pokemon.get("poke_type"));
  this.$pokeList.append($li);
  $li.addClass("poke-list-item");
  $li.data("id", pokemon.id);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: function() {
      this.pokes.each(function(pokemon) {
        this.addPokemonToList(pokemon);
      }.bind(this));
    }.bind(this)
  });

};
