class Dictionary
  attr_reader :dictionary

  def initialize
    @dictionary = File.read('google-10000-english-no-swears.txt')
  end

  def trim_dictionary
    result = []
    words = @dictionary.split("\n")
    words.each do |word|
      result.push(word) if word.length >= 5 && word.length <= 12
    end
    result
  end
end
