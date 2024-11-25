require_relative '../dictionary'
require_relative '../game'
require 'test/unit'

class GameTest < Test::Unit::TestCase
  def test_initialize
    game = Game.new(%w[w o r d])
    expected = %w[_ _ _ _]
    assert_equal(expected, game.guess)
  end

  def test_update_guess
    game = Game.new(%w[w o o k i e])
    choice = 'o'
    expected = %w[_ o o _ _ _]
    assert_equal(expected, game.update_guess(choice))
  end
end
