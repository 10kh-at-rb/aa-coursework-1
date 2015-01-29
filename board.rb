#encoding: utf-8

class Board
  attr_accessor :board
  def initialize(new_board = true)
    @board = Array.new(8) { Array.new(8) }
    if new_board
      board_setup
    end
  end

  # def [](pos)
  #   i, j = pos
  #   @board[i][j] = pos
  # end

  def dup
    duped_board = Board.new(false)
    @board.flatten.compact.each do |piece|
      x = piece.pos.first
      y = piece.pos.last
      color = piece.color
      duped_board.board[x][y] = Piece.new(duped_board, [x,y], color)
      # duped_board.board[x][y].board = duped_board
    end
    duped_board
  end

  def board_setup
    0.upto(2) do |x|
      0.upto(7) do |y|
        if (x + y).odd?
          @board[x][y] = Piece.new(self, [x,y], :white)
        end
      end
    end

    5.upto(7) do |x|
      0.upto(7) do |y|
        if (x + y).odd?
          @board[x][y] = Piece.new(self, [x,y], :black)
        end
      end
    end
    nil
  end

  def print_current_board
    print " abcdefgh\n"
    @board.each_with_index do |row, x|
      print "#{8 - x}"
      row.each_with_index do |tile, y|
        if tile.nil?
          if (x.even? && y.even?) || (x.odd? && y.odd?)
            print " "
          else
            print " ".on_light_white
          end
        else
          print tile.display.encode('utf-8').on_light_white
        end
      end
      print "\n"
    end
    nil
  end

end
