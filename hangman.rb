class Hangman
  TURNS = 5

  def initialize(word_picker, guesser)
    @word_picker = word_picker
    @guesser = guesser
  end

  def play
    turns_left = TURNS
    @word_picker.pick_secret_word
    @guesser.receive_secret_length(@word_picker.secret_word.length)
    while @guesser.guessed_chars.include?(nil) && turns_left > 0
      display(@guesser.guessed_chars)
      puts "You have guessed the following letters: "\
      "#{@guesser.used_chars.join(',')}"
      guess = @guesser.guess
      indices = @word_picker.check_guess(guess)
      turns_left -= 1 if indices.empty?
      @guesser.handle_guess_response(indices)
      puts "You have #{turns_left} turns remaining"
    end
  end

  def display(guessed_chars)
    word_output = ""
    guessed_chars.each do |char|
      if char.nil?
        word_output << "_"
      else
        word_output << char
      end
    end
    puts word_output
  end

end

class Player
  attr_reader :guessed_chars, :secret_word, :used_chars

  def initialize
    @guessed_chars = [] #correctly guessed letters
    @used_chars = [] #previously guessed letters
  end

  def pick_secret_word

  end

  def receive_secret_length(length)
    @guessed_chars = Array.new(length, nil)
  end

  def guess

  end

  def check_guess(guess)
    indices = []
    0.upto(@secret_word.length) do |i|
      indices << i if @secret_word[i] == guess
    end
    indices
  end

  def handle_guess_response(indices)
    if indices.empty?
      puts "Your guess was not in the secret word."
    else
      indices.each do |i|
        @guessed_chars[i] = @guess
      end
    end
  end

end

class HumanPlayer < Player

  def pick_secret_word
    print "Please enter your secret word: "
    @secret_word = gets.chomp.downcase
  end

  def guess
    print "Please guess a character: "
    @guess = gets.chomp[0].downcase
    @used_chars << @guess
    @guess
  end

end

class ComputerPlayer < Player
  def initialize
    super
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
  end

  def guess
    valid = false
    until valid
      @guess = ('a'..'z').to_a.sample
      valid = true unless @used_chars.include?(guess)
    end
    @used_chars << @guess
    @guess
  end

end
