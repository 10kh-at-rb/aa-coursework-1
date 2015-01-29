#encoding: utf-8
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    board_setup
  end

  # def [](pos)
  #   i, j = pos
  #   @board[i][j] = pos
  # end

  def board_setup
    0.upto(2) do |x|
      0.upto(7) do |y|
        if (x + y).odd?
          @board[x][y] = Piece.new(@board, [x,y], :white)
        end
      end
    end

    5.upto(7) do |x|
      0.upto(7) do |y|
        if (x + y).odd?
          @board[x][y] = Piece.new(@board, [x,y], :black)
        end
      end
    end
    nil
  end

  def print_current_board
    @board.each do |row|
      row.each do |tile|
        if tile.nil?
          print "+"
        elsif tile.color == :black && tile.king
          print "♛"
        elsif tile.color == :white && tile.king
          print "♕"
        elsif tile.color == :black
          print "⚈"
        elsif tile.color == :white
          print "⚆"
        end
      end
      print "\n"
    end
    nil
  end

end
