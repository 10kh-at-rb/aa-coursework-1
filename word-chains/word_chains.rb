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
    @all_seen_words = { source => nil }
    until @current_words.empty? || @all_seen_words.include?(target)
      new_current_words = []
      explore_current_words(new_current_words)
    end
    word_chain = build_path(target)
    if word_chain.nil?
      puts "No path found!"
    else
      word_chain.reverse.each { |word| puts word }
    end
  end

  def explore_current_words(new_current_words)
    @current_words.each do |word|
      new_adjacent_words = adjacent_words(word)
      new_adjacent_words.each do |adjacent_word|
        if !@all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = word
        end
      end
    end
    @current_words = new_current_words
  end

  def build_path(target)
    current_word = target
    path = [current_word] unless @all_seen_words[current_word].nil?
    until @all_seen_words[current_word].nil?
      path << current_word = @all_seen_words[current_word]
    end
    path
  end
end
