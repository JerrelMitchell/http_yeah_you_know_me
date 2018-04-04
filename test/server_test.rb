require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/unit'
require 'mocha/minitest'
require './lib/server'
require 'pry'

# incomplete test suite for server class
class ServerTest < Minitest::Test
  attr_reader :server
  def setup
    @server = Server.new(0000)
  end

  def test_it_exists
    assert_instance_of Server, server
  end

  def test_connection_is_off_by_default
    assert_equal 'off', server.connection
  end

  def test_it_has_empty_request_lines_by_default
    assert_equal [], server.lines
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

  def test_it_has_access_to_requested_info
    expected = %(Verb: POST\n
      Path: /\n
      Protocol: HTTP/1.1\n
      Host: 127.0.0.1\n
      Port: 9292\n
      Origin: 127.0.0.1\n
      Accept: text/html,application/xhtml+xml,application/xml;q=0.9\n
      image/webp,*/*;q=0.8\n)
    assert_equal expected, server.requested_info
  end
end
