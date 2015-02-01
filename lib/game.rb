require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :players
  def initialize
    @deck = Deck.new(Deck.start_deck)
    @pot = 0
  end

  def play
    @players = []
    4.times do |i|
      puts "Please enter the name of Player #{i + 1}:"
      name = gets.chomp
      @players << Player.new(Hand.new([], @deck), name)
    end

    until @players.count == 1
      @deck.shuffle
      @current_bet = 50
      @current_players = []

      @players.each { |player| @current_players << player }

      @current_players.each do |player|
        if player.hand.hand.empty?
          player.hand.receive(@deck.take(5))
        end
      end

      @current_players.each do |player|
        print "Player: #{player.name } Current Pot: #{@pot} " +
        "Current Bet: #{@current_bet} Player Pot: #{player.pot}\n Current Hand:"
        player.hand.hand.each do |card|
          print " #{card.to_s}"
        end
        print "\n"

        player_options(player)
      end

      @current_players.each do |player|
        puts "Player #{player.name}: "
        print "Current Hand:"
        player.hand.hand.each do |card|
          print " #{card.to_s}"
        end
        print "\n"
        player.discard
      end

      @current_players.each do |player|
        print "Player: #{player.name } Current Pot: #{@pot} " +
        "Current Bet: #{@current_bet} Player Pot: #{player.pot}\n Current Hand:"
        player.hand.hand.each do |card|
          print " #{card.to_s}"
        end
        print "\n"

        player_options(player)
      end

      @current_players.each do |player|
        @current_players.each do |other_player|
          next if player == other_player
          next if player.nil? || other_player.nil?
          if player.hand.loses_to?(other_player.hand)
            @deck.return_cards(player.hand.hand)
            player.hand.hand = []
            @current_players.delete(player)
          end
        end
      end

      @current_players.each do |player|
        player.pot += (@pot / @current_players.count)
      end

      @pot = 0

      @current_players.delete_if {|player| player.pot == 0}
    end
  end

  def player_options(player)
    begin
      option = player.option
      if option == 1
        @deck.return_cards(player.hand.hand)
        player.hand.hand = []
        @current_players.delete(player)
      elsif option == 2
        if player.pot < @current_bet
          @pot += player.pot
          player.pot = 0
        else
          @pot += current_bet
          player.pot -= @current_bet
        end
      else
        if (@current_bet + 50) > player.pot
          raise "not enough money to raise bet"
        else
          @current_bet += 50
          @pot += @current_bet
          player.pot -= @current_bet
        end
      end
    rescue
      retry
    end
  end
end
