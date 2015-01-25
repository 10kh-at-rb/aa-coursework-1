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

end
