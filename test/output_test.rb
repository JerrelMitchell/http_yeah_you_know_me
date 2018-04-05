require 'minitest/autorun'
require 'minitest/pride'
require './lib/output'

class OutputTest < Minitest::Test
  attr_reader :output
  def setup
    @output = Output.new(0)
  end

  def test_it_exists
    assert_instance_of Output, output
  end

  def test_it_has_headers
    assert_equal "http/1.1 \r\n\r\n", output.headers
  end

  def test_it_can_request_a_guess
    expected = 'Enter a VALID whole number between 0 and 100...'
    assert_equal expected, output.request_guess
  end

  def test_it_can_tell_you_your_guess_was_correct
    expected = '53 was a good guess. You win! Congratulations!'
    assert_equal expected, output.correct_guess(53)
  end

  def test_it_can_tell_you_your_guess_was_too_high
    expected = '77? Too high. Try again.'
    assert_equal expected, output.guess_too_high(77)
  end

  def test_it_can_tell_you_your_guess_was_too_low
    expected = '25? Too low. Try again.'
    assert_equal expected, output.guess_too_low(25)
  end

  def test_it_gives_an_error_if_game_was_not_started_before_guessing
    expected = %(You have not started a game, or you have not made any guesses.
      Please start a game by posting to the path '/start_game'.)
    assert_equal expected, output.game_error_message
  end
end
