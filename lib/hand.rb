class Hand
  attr_reader :hand

  def initialize(hand, deck)
    @hand = hand
    @deck = deck
  end

  def receive(new_cards)
    @hand += new_cards
  end

  def discard(card_indices)
    discard_pile = []
    card_indices.each do |i|
      discard_pile << @hand[i]
    end

    @hand.delete_if {|card| discard_pile.include?(card) }

    receive(@deck.take(discard_pile.count)) #receives new cards
    @deck.return_cards(discard_pile) #puts those discarded cards back into deck
    discard_pile
  end

  def points
    @suits_hash = Hash.new(0)
    @values_hash = Hash.new(0)
    @hand.each do |card|
      @suits_hash[card.suit] += 1
      @values_hash[card.value] += 1
    end

    return 8 if straight_flush?
    return 7 if four_of_a_kind?
    return 6 if full_house?
    return 5 if flush?
    return 4 if straight?
    return 3 if three_of_a_kind?
    return 2 if two_pair?
    return 1 if one_pair?
    0
  end

  def straight_flush?
    @suits_hash.values.max == 5 && straight?
  end

  def four_of_a_kind?
    @values_hash.values.max == 4
  end

  def full_house?
    @values_hash.values.max == 3 && @values_hash.values.include?(2)
  end

  def flush?
    @suits_hash.values.max == 5
  end

  def straight?
    if @hand.all? {|card| card.value != :ace }
      card_values = []
      @hand.each { |card| card_values << card.poker_value }
      card_values.sort!
      return true if card_values.last - card_values.first == 4
    else
      if @hand.all? do |card|
        card.value == :ace || card.value == :deuce || card.value == :three ||
        card.value == :four || card.value == :five
        end
        return true
      elsif @hand.all? do |card|
        card.value == :ace || card.value == :king || card.value == :queen ||
        card.value == :jack || card.value == :ten
        end
        return true
      end
    end
    false
  end

  def three_of_a_kind?
    @values_hash.values.max == 3
  end

  def two_pair?
    @values_hash.values.count(2) == 2
  end

  def one_pair?
    @values_hash.values.count(2) == 1
  end

  def loses_to?(other_hand)
    if points < other_hand.points
      return true
    elsif points == 0 && other_hand.points == 0
      hand_values = []
      other_hand_values = []
      @hand.each {|card| hand_values << card.poker_value }
      other_hand.hand.each {|card| other_hand_values << card.poker_value}
      if hand_values.max < other_hand_values.max
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
