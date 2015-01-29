class Player
  attr_accessor :name

  POSITION_CONVERSION = {
    "A" => 0,
    "B" => 1,
    "C" => 2,
    "D" => 3,
    "E" => 4,
    "F" => 5,
    "G" => 6,
    "H" => 7,
    "8" => 0,
    "7" => 1,
    "6" => 2,
    "5" => 3,
    "4" => 4,
    "3" => 5,
    "2" => 6,
    "1" => 7
  }

  def initialize(color)
    @color = color
  end

  def play_turn
    begin
      puts "Enter the checker you wish to move: "
      start_pos = gets.chomp.upcase.split('')
      unless start_pos.length == 2
        raise ArgumentError.new "Invalid piece location."
      end
      puts "Enter a valid move chain: "
      move_chain = gets.chomp.upcase.split(' ')
      move_chain.map! { |move| move.split('') }

      # unless start_pos[0].between?("A", "H") && end_pos[0].between?("A", "H")
      #   raise ArgumentError.new "Invalid letter input."
      # end
      # unless start_pos[1].between?("1", "8") && end_pos[1].between?("1", "8")
      #   raise ArgumentError.new "Invalid number input."
      # end
    rescue ArgumentError => e
      puts "#{e.message}"
      retry
    end

    start_pos.map! { |i| POSITION_CONVERSION[i] }
    start_pos.reverse!

    p "move chain before conversion: #{move_chain}"
    move_chain.each do |pair|
      pair.map! { |i| POSITION_CONVERSION[i] }
    end
    p "move chain after conversion: #{move_chain}"
    move_chain.each do |move|
      move.reverse!
    end
    p "move chain after reversal: #{move_chain}"
    # start_pos = start_pos.split(",").map { |num| num.to_i }
    # end_pos = end_pos.split(",").map { |num| num.to_i }

    [start_pos, move_chain]
  end
end
