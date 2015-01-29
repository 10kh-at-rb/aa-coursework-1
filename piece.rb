class Piece
  attr_reader :color, :pos, :king
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @board[pos.first][pos.last] = self
    @color = color
    @king = false
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


  def perform_slide?(pos)
    possible_moves = moves
    possible_moves.reject! { |x,y| !@board[x][y].nil? }
    possible_moves.include?(pos)
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
      jumps << [new_x, new_y] if @board[new_x][new_y].nil?
    end
    jumps
  end


  def perform_jump?(pos)
    jumps.include?(pos)
  end

  def perform_jump(pos)
    jumped_x = (pos.first + @pos.first) / 2
    jumped_y = (pos.last + @pos.last) / 2
    @board[median_x][median_y] = nil
    @board[pos.first][pos.last] = self
    @board[@pos.first][pos.last] = nil
  end

  def maybe_promote
    if (@pos.first == 0 && @color == :black) ||
       (@pos.first == 7 && @color == :white)
        @king = true
    end
  end

end
