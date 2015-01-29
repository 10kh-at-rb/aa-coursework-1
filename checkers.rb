class Checkers
  attr_accessor :player1, :player2, :board
  def initialize
    @board = Board.new
    @player1_turn = false
  end

  def play
    print_welcome
    get_players

    until false
      switch_turn
      break if @board.no_moves?(current_player.color)
      turn(current_player)
    end
    switch_turn
    @board.print_current_board
    puts "Congratulations #{current_player.name}!  You won!"
  end

  def switch_turn
    @player1_turn = !@player1_turn
  end

  def current_player
    @player1_turn ? @player1 : @player2
  end

  def turn(player)
    @board.print_current_board
    puts "Current Turn: #{player.name}"
    moves = player.play_turn
    piece = moves.first
    move_chain = moves.last
    @board.board[piece.first][piece.last].perform_moves(move_chain)
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
