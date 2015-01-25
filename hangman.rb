class Hangman
  def initialize(dictionary)
    @dictionary = File.readlines(dictionary).map(&:chomp)
  end
  
end

class Player

end

class HumanPlayer

end

class ComputerPlayer

end
