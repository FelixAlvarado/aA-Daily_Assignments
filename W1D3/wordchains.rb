class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines("#{dictionary_file_name}.txt").map(&:chomp))
  end

  def adjacent_words(word)
    result = []
    word.length.times do |idx|
      result += @dictionary.select do |words|
        words[0...idx] == word[0...idx] && words[idx + 1..-1] == word[idx + 1..-1]
    end
  end
  result.uniq
  end

  # def inspect
  #   p ""
  # end


  def run(source, target)
    @current_words = Set.new([source])
    @all_seen_words = { source => nil }
    until @current_words.empty?
      new_current_words = explore_current_words(target)
      print new_current_words
      return target if @current_words.include?(target)
      @current_words = new_current_words
    end

  end

  def explore_current_words(target)
    result = Set.new
      @current_words.each do |word|
        adjacent_words(word).each do |adj|

          if @all_seen_words[adj].nil?
            @all_seen_words[adj] = word
            result << adj
          end

                   #  unless @all_seen_words.include?(adj)
          #    result << adj
          #    @all_seen_words << adj
          # end
        end
      end
    result
  end

end
