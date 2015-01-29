class Checkers
  attr_accessor :player1, :player2
  def initialize
    @board = Board.new
  end

  def play
    print_welcome
    get_players

    until false
      @board.print_current_board
      @player1.play_turn
    end
  end

  def print_welcome
    puts "Welcome to Checkers. Player 1 will be black, Player 2 will be white."
  end

  def get_players
    @player1 = Player.new(:black)
    puts "Please enter Player 1's name: "
    @player1.name = gets.chomp

    @player2 = Player.new(:white)
    puts "Please enter Player 2's name: "
    @player2.name = gets.chomp
  end

end
