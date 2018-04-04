require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'pry'

class ServerMessagesTest < Minitest::Test
  attr_reader :server
  def setup
    @server = Server.new(0000)
  end

  def test_it_can_show_and_add_number_of_requests_to_client
    expected = "\nHello World! (0)"
    assert_equal expected, server.hello_response

    10.times do
      server.add_request
    end

    expected = "\nHello World! (10)"
    assert_equal expected, server.hello_response
  end

  def test_it_has_access_to_headers_array
    assert_equal ['http/1.1 200 ok'], server.headers
  end

end
