require 'set'
class WordChainer
  def initialize(dictionary_file_name = "dictionary.txt")
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end
  
  def adjacent_words(word)
    same_length_words = @dictionary.select { |entry| entry.length == word.length}
    same_length_words.select do |entry|
      differences = 0
      entry.length.times do |i|
        differences += 1 unless entry[i] == word[i]
      end
      differences == 1
    end
  end
  
  def run(source, target)
    @current_words = [source]
    @all_seen_words = {}
    @all_seen_words[source] = nil
    until @current_words.empty? || @all_seen_words.has_key?(target)
      @current_words = explore_current_words
    end
    puts build_path(target)
  end
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.has_key?(adjacent_word)
        @all_seen_words[adjacent_word] = current_word
        new_current_words << adjacent_word
      end
    end
    new_current_words
  end
  
  def build_path(target)
    current_word = target
    path = []
    until @all_seen_words[current_word].nil?
      path << current_word
      current_word = @all_seen_words[current_word]
    end
    path << current_word
    path.reverse
  end
end