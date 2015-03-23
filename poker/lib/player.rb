class Player
  attr_reader :hand, :name
  attr_accessor :pot
  def initialize(hand, name)
    @name = name
    @hand = hand
    @pot = 300
  end

  def discard
    puts "Do you wish to discard any cards? (y/n)"
    choice = gets.chomp[0].downcase
    if choice == "y"
      puts "Which cards would you like to discard? (ex: 2 3 4)"
      discard_cards = gets.chomp.split
      discard_cards.map! {|card| card.to_i - 1}
      hand.discard(discard_cards)
    elsif choice != "n"
      raise "you did not select a valid option"
    end
  end

  def option
    puts "Select an option: 1. Fold 2. See 3. Raise"
    choice = gets.chomp[0].to_i
  end
end
