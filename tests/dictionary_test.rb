require_relative '../dictionary'
require 'test/unit'

class DictionaryTest < Test::Unit::TestCase
  def test_initialize
    dictionary = Dictionary.new
    expected = 'the'
    assert_equal(expected, dictionary.dictionary.lines.first.chomp)
  end

  def test_trim_dictionary
    dictionary = Dictionary.new.trim_dictionary
    expected = 'about'
    assert_equal(expected, dictionary[0])
  end
end
