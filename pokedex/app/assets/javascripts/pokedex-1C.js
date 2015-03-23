Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon();
  pokemon.save(attrs, {

    success: function() {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback(pokemon);
    }.bind(this),

    error: function() {
      console.log("Invalid Pokemon");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var $formData = $(event.currentTarget).serializeJSON();
  this.createPokemon($formData.pokemon, this.renderPokemonDetail.bind(this));
};
