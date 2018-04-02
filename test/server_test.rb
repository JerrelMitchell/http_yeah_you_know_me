require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/unit'
require 'mocha/minitest'
require './lib/server'

class ServerTest < Minitest::Test
  attr_reader :server
  def setup
    @server = Server.new
  end

  def test_it_exists
    assert_instance_of Server, server
  end

  def test_it_has_a_nil_socket_by_default
    assert_nil server.socket
  end

  def test_it_has_empty_lines_by_default
    assert_equal [], server.lines
  end

  def test_it_has_a_nil_request_by_default
    assert_nil server.request
  end

  def test_it_has_a_nil_client_by_default
    assert_nil server.client
  end

  def test_it_can_show_number_of_visits_to_page
    expected = "Hello World! (0)\n"
    assert_equal expected, server.hello_response(0)

    expected = "Hello World! (5)\n"
    assert_equal expected, server.hello_response(5)

    expected = "Hello World! (10)\n"
    assert_equal expected, server.hello_response(10)
  end

  def test_it_can_be_prompted_to_start_with_a_port_number
    skip
    server.start(0)
    assert_instance_of TCPServer, server.client
  end

  def test_it_can_request_and_add_lines_from_server_socket
    skip
  end

  def test_it_has_headers
    skip
  end

  def test_it_has_footers
    skip
  end

  def test_it_adds_output_to_head_and_body_of_page
    skip
  end

  def test_it_adds_preformat_tags_to_output
    skip
  end

end
