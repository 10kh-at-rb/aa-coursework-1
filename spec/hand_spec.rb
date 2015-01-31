require 'hand.rb'

describe Hand do
  subject(:hand) { Hand.new([
    Card.new(:clubs, :three),
    Card.new(:hearts, :five),
    Card.new(:diamonds, :seven),
    Card.new(:spades, :four),
    Card.new(:diamonds, :eight)
    ], Deck.new(Deck.start_deck))}

  subject(:two_card_hand) { Hand.new([
    Card.new(:clubs, :three),
    Card.new(:hearts, :five)
    ], Deck.new(Deck.start_deck))}

  describe "#hand" do
    it "should return the current hand" do
      expect(hand.hand).to eq([
        Card.new(:clubs, :three),
        Card.new(:hearts, :five),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :four),
        Card.new(:diamonds, :eight)
        ])
    end
  end

  describe "#discard" do
    it "removes 3 cards from hand and gets 3 new ones" do
      hand.discard([0,2,4])
      expect(hand.hand).to_not eq([
        Card.new(:clubs, :three),
        Card.new(:hearts, :five),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :four),
        Card.new(:diamonds, :eight)
        ])

        expect(hand.hand.count).to eq(5)
    end

    it "returns discarded pile correctly" do
      returned_cards = hand.discard([0,2,4])
      expect(returned_cards[0].suit).to eq(:clubs)
      expect(returned_cards[0].value).to eq(:three)

      expect(returned_cards[1].suit).to eq(:diamonds)
      expect(returned_cards[1].value).to eq(:seven)

      expect(returned_cards[2].suit).to eq(:diamonds)
      expect(returned_cards[2].value).to eq(:eight)
    end

  end

  describe "#receive" do
    it "receives 3 new cards" do
      new_cards = [
        Card.new(:diamonds, :four),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :seven)
      ]
      two_card_hand.receive(new_cards)
      expect(two_card_hand.hand.count).to eq(5)
    end

  end

  describe "#points" do
    it "should return 8 points for a straight flush with no aces" do
        straight_flush_hand = Hand.new([
        Card.new(:clubs, :five),
        Card.new(:clubs, :four),
        Card.new(:clubs, :three),
        Card.new(:clubs, :six),
        Card.new(:clubs, :seven)], Deck.new(Deck.start_deck))

        expect(straight_flush_hand.points).to eq(8)
    end

    it "should return 8 points for a straight flush with low ace" do
        straight_flush_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:clubs, :four),
        Card.new(:clubs, :three),
        Card.new(:clubs, :deuce),
        Card.new(:clubs, :five)], Deck.new(Deck.start_deck))

        expect(straight_flush_hand.points).to eq(8)
    end

    it "should return 8 points for a straight flush with high ace" do
        straight_flush_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:clubs, :king),
        Card.new(:clubs, :jack),
        Card.new(:clubs, :queen),
        Card.new(:clubs, :ten)], Deck.new(Deck.start_deck))

        expect(straight_flush_hand.points).to eq(8)
    end

    it "should return 7 points for four of a kind" do
        four_kind_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:clubs, :king),
        Card.new(:diamonds, :king),
        Card.new(:hearts, :king),
        Card.new(:spades, :king)], Deck.new(Deck.start_deck))

        expect(four_kind_hand.points).to eq(7)
    end

    it "should return 6 points for a full house" do
        full_house_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:diamonds, :ace),
        Card.new(:hearts, :king),
        Card.new(:spades, :king),
        Card.new(:clubs, :king)], Deck.new(Deck.start_deck))

        expect(full_house_hand.points).to eq(6)
    end

    it "should return 5 points for a flush" do
        flush_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:clubs, :queen),
        Card.new(:clubs, :six),
        Card.new(:clubs, :deuce),
        Card.new(:clubs, :nine)], Deck.new(Deck.start_deck))

        expect(flush_hand.points).to eq(5)
    end

    it "should return 4 points for a straight with no aces" do
      straight_hand = Hand.new([
        Card.new(:clubs, :eight),
        Card.new(:hearts, :seven),
        Card.new(:diamonds, :six),
        Card.new(:spades, :five),
        Card.new(:clubs, :four)], Deck.new(Deck.start_deck))

        expect(straight_hand.points).to eq(4)
    end

    it "should return 4 points for a straight with low ace" do
      straight_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:hearts, :deuce),
        Card.new(:diamonds, :three),
        Card.new(:spades, :five),
        Card.new(:clubs, :four)], Deck.new(Deck.start_deck))

        expect(straight_hand.points).to eq(4)
    end

    it "should return 4 points for a straight with high ace" do
      straight_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:hearts, :queen),
        Card.new(:diamonds, :king),
        Card.new(:spades, :jack),
        Card.new(:clubs, :ten)], Deck.new(Deck.start_deck))

        expect(straight_hand.points).to eq(4)
    end

    it "should return 3 points for a three of a kind" do
      three_of_a_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:hearts, :nine),
        Card.new(:diamonds, :nine),
        Card.new(:spades, :nine),
        Card.new(:clubs, :ten)], Deck.new(Deck.start_deck))

        expect(three_of_a_hand.points).to eq(3)
    end


    it "should return 2 points for two pairs" do
      two_pair_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:hearts, :nine),
        Card.new(:diamonds, :nine),
        Card.new(:spades, :eight),
        Card.new(:clubs, :eight)], Deck.new(Deck.start_deck))

        expect(two_pair_hand.points).to eq(2)
    end

    it "should return 1 point for one pair" do
      one_pair_hand = Hand.new([
        Card.new(:clubs, :ace),
        Card.new(:hearts, :nine),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :eight),
        Card.new(:clubs, :eight)], Deck.new(Deck.start_deck))

        expect(one_pair_hand.points).to eq(1)
    end

  end

end
