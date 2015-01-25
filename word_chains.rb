require 'set'

class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(@dictionary)
  end

  def dictionary
    @dictionary
  end

  def adjacent_words(word)
    return_dictionary = @dictionary.dup
    return_dictionary.delete_if do |comparison_word|
      comparison_word.length != word.length
    end

    return_dictionary.delete_if do |comparison_word|
      count = 0
      0.upto(word.length) do |char|
        count += 1 if word[char] != comparison_word[char]
      end

      count != 1
    end

    return_dictionary
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]
    until @current_words.empty?
      new_current_words = []
      @current_words.each do |word|
        new_adjacent_words = adjacent_words(word)
        new_adjacent_words.each do |adjacent_word|
          if !@all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words << adjacent_word
          end
        end
      end
      new_current_words.each { |word| puts word }
      @current_words = new_current_words
    end
  end

end
