class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
  end

  def dictionary
    @dictionary
  end

end
