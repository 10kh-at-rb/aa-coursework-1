require 'player.rb'

describe Player do
  subject(:player) { Player.new(Hand.new([
    Card.new(:clubs, :three),
    Card.new(:hearts, :five),
    Card.new(:diamonds, :seven),
    Card.new(:spades, :four),
    Card.new(:diamonds, :eight)
    ], Deck.new(Deck.start_deck))) }

  describe '#hand' do
    it "returns a player hand" do
      expect(player.hand.hand.count).to eq(5)
    end
  end

  describe '#pot' do
    it "returns the pot" do
      expect(player.pot).to eq(300)
    end

    it "can have the pot decreased" do
      player.pot = player.pot - 100
      expect(player.pot).to eq(200)
    end

    it "can have the pot increased" do
      player.pot = player.pot + 100
      expect(player.pot).to eq(400)
    end
  end

end
