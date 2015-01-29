class ComputerPlayer < Player
  def initialize(color, board)
    super
    @name = "Computer"
  end

  def play_turn
    pieces_arr = @board.pieces(@color)

    jumps = Hash.new()
    pieces_arr.each do |piece|
      jumps[piece] = piece.jumps if !piece.jumps.empty?
    end

    unless jumps.empty?
      piece = jumps.keys.sample
      move = jumps[piece].sample
      return [piece.pos, [move]]
    end

    moves = Hash.new()
    pieces_arr.each do |piece|
      moves[piece] = piece.available_moves if !piece.available_moves.empty?
    end

    piece = moves.keys.sample
    move = moves[piece].sample
    p piece.object_id
    p move
    return [piece.pos, [move]]
  end
end
