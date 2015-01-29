#encoding: utf-8
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  # def [](pos)
  #   i, j = pos
  #   @board[i][j] = pos
  # end

  def print_current_board
    @board.each do |row|
      row.each do |tile|
        if tile.nil?
          print " "
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
  end

end
