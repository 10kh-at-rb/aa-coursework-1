// Pokedex.RootView.prototype.addToyToList = function (toy) {
//
// };
//
// Pokedex.RootView.prototype.renderToyDetail = function (toy) {
//
// };

Pokedex.RootView.prototype.reassignToy = function (event) {
  var $select = this.$toyDetail.find(".pokemon-dropdown");
  var oldPokemonID = $select.data("pokemon-id");
  var newPokemonID = $select.val();
  var toyID = $select.data("toy-id");

  var oldPokemon = this.pokes.get(oldPokemonID);
  var toy = oldPokemon.toys().get(toyID);


  toy.set("pokemon_id", newPokemonID);
  toy.save({}, {
    success: function(){
      oldPokemon.toys().remove(toy);
      this.renderToysList(oldPokemon.toys());
      this.$toyDetail.empty();
    }.bind(this)
  });
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.each(function (toy) {
    this.addToyToList(toy);
  }.bind(this))
};
