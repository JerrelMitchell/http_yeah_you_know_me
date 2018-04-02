require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_counter'

class RequestCounterTest < Minitest::Test
  def test_it_exists
    request = RequestCounter.new
    assert_instance_of RequestCounter, request
  end

  def test_it_has_zero_requests_by_default
    request = RequestCounter.new
    assert_equal 0, request.count
  end

  def test_it_can_add_requests_to_counter
    request = RequestCounter.new
    assert_equal 0, request.count
    request.add_request
    assert_equal 1, request.count
    5.times { request.add_request }
    assert_equal 6, request.count
  end
end
