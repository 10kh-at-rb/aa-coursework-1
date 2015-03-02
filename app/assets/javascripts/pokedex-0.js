window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

var Pokemon = Pokedex.Models.Pokemon = Backbone.Model.extend({ urlRoot: "/pokemon"}); // WRITE ME

Pokedex.Models.Toy = Backbone.Model.extend({urlRoot: "/toys"}); // WRITE ME IN PHASE 2

Pokedex.Collections.Pokemon = Backbone.Collection.extend({ url: "/pokemon", model: Pokedex.Models.Pokemon}); // WRITE ME

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({ url: "/toys", model: Pokedex.Models.Toy }); // WRITE ME IN PHASE 2

Pokemon.prototype.toys = function () {
  this._toys = this._toys || new Pokedex.Collections.PokemonToys;

  return this._toys;
};

Pokemon.prototype.parse = function(payload) {
  if (typeof payload.toys !== "undefined") {
    this.toys().set(payload.toys);
    delete payload.toys;
  }
  return payload;
};

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  // Click handlers go here.
  this.$el.on("click", ".poke-list-item", this.selectPokemonFromList.bind(this));
  this.$el.on("submit", ".new-pokemon", this.submitPokemonForm.bind(this));
  this.$el.on("click", ".pokemon-detail .toys li", this.selectToyFromList.bind(this));
  this.$el.on("change", ".toy-detail", this.reassignToy.bind(this));
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
