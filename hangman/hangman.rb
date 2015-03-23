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
      puts "You have #{turns_left} turns remaining."
    end
    if @guesser.guessed_chars.include?(nil)
      puts "Sorry, you lost, the secret word was: #{@word_picker.secret_word}."
    else
      puts "Congratulations, you won!"
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
    print "Please select your secret word: "
    @secret_word = gets.chomp
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
      trim_dictionary(false)
    else
      indices.each do |i|
        @guessed_chars[i] = @guess
        trim_dictionary(true)
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

  def receive_secret_length(length)
    super
    @dictionary.select! { |word| word.length == length }
  end

  def guess
    letter_hash = Hash.new(0)
    @dictionary.each do |word|
      word.each_char do |char|
        letter_hash[char] += 1
      end
    end
    letter_hash.reject! { |char| @used_chars.include?(char) }
    @guess = letter_hash.sort_by { |key, value| value }[-1][0]
    @used_chars << @guess
    @guess
  end

  def trim_dictionary(guessed)
    if guessed
      @dictionary.delete_if do |word|
        non_match = false
        @guessed_chars.each_with_index do |char, index|
          next if char.nil?
          if word[index] != char
            non_match = true
            break
          end
        end
        non_match
      end
    else
      @dictionary.delete_if do |word|
        word.include?(@guess)
      end
    end
  end
end
