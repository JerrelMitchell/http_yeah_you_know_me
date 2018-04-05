require 'minitest/autorun'
require 'minitest/pride'
require './lib/router'

class RouterTest < Minitest::Test
  attr_reader :router, :lines
  def setup
    @router = Router.new('Blank Server')
    @lines  = [%(Verb: GET
        Path: /
        Protocol: HTTP/1.1
        Host: 127.0.0.1
        Port: 9292
        Origin: 127.0.0.1
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9
        image/webp,*/*;q=0.8)]
  end

  def test_it_exists
    assert_instance_of Router, router
  end

  def test_it_can_find_verb
    result = lines[0].split[0]
    assert_equal 'Verb:', result
  end

  def test_it_can_make_a_path_to_verb_data
    result = lines[0].split[1]
    assert_equal 'GET', result
  end
end
