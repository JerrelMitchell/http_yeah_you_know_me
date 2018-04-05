require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new(0)
    assert_instance_of Game, game
  end

  def test_it_initializes_with_an_instance_of_output_class
    game = Game.new(0)
    assert_instance_of Output, game.output
  end

  def test_it_initializes_with_a_random_number_between_0_and_100
    game = Game.new(0)
    result = game.rand_num
    assert_equal result, game.rand_num
  end
end
