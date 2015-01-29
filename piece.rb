class Piece
  attr_reader :color, :pos, :king
  def initialize(board_object, pos, color)
    @board_object = board_object
    @board = @board_object.board
    @pos = pos
    @board[pos.first][pos.last] = self
    @color = color
    @king = false
  end

  def dup

  end

  def moves
    direction = (@color == :black ? -1 : 1)
    moves = []
    moves << [@pos.first + direction, @pos.last - 1]
    moves << [@pos.first + direction, @pos.last + 1]
    if @king
      moves << [@pos.first - direction, @pos.last - 1]
      moves << [@pos.first - direction, @pos.last + 1]
    end
    moves.reject! { |move| move.min < 0 || move.max > 7}
    moves
  end


  def perform_slide(pos)
    possible_moves = moves
    possible_moves.reject! { |x,y| !@board[x][y].nil? }
    return false unless possible_moves.include?(pos)
    @board[pos.first][pos.last] = self
    @board[@pos.first][@pos.last] = nil
    @pos = pos
    maybe_promote
    true
  end

  def jumps
    possible_jumps = moves
    possible_jumps.reject! do |x,y|
      @board[x][y].nil? || @board[x][y].color == @color
    end
    jumps = []
    possible_jumps.each do |x,y|
      new_x = (x - @pos.first) + x
      new_y = (y - @pos.last) + y
      next if [new_x, new_y].min < 0 || [new_x, new_y].max > 7
      jumps << [new_x, new_y] if @board[new_x][new_y].nil?
    end
    jumps
  end


  def perform_jump(pos)
    return false unless jumps.include?(pos)
    jumped_x = (pos.first + @pos.first) / 2
    jumped_y = (pos.last + @pos.last) / 2
    @board[jumped_x][jumped_y] = nil
    @board[pos.first][pos.last] = self
    @board[@pos.first][@pos.last] = nil
    @pos = pos
    maybe_promote
    true
  end

  def maybe_promote
    if (@pos.first == 0 && @color == :black) ||
       (@pos.first == 7 && @color == :white)
        @king = true
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      unless perform_slide(move_sequence[0])
        unless perform_jump(move_sequence[0])
          raise InvalidMoveError.new
          "#{move_sequence[0]} was not a valid Jump or Slide."
        end
      end
    else
      move_sequence.each do |move|
        unless perform_jump(move)
          raise InvalidMoveError.new
          "#{move_sequence[0]} was not a valid Jump or Slide."
        end
      end
    end
    nil
  end

  def valid_moves_seq?(move_sequence)
    duped_board = @board_object.dup
    begin
      duped_board.board[@pos.first][@pos.last].perform_moves!(move_sequence)
    rescue InvalidMoveError => e
      return false
    else
      return true
    end
  end

  def perform_moves(move_sequence)
    if valid_moves_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError.new "#{move_sequence} was not valid."
    end
  end

  def display
    if @color == :black && @king
      "♛"
    elsif @color == :white && @king
      "♕"
    elsif @color == :black
      "◉"
    else
      "◎"
    end
  end

end

class InvalidMoveError < StandardError
end
