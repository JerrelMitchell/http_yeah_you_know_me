require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/unit'
require 'mocha/minitest'
require './lib/server'

class ServerTest < Minitest::Test
  attr_reader :server
  def setup
    @server = Server.new(0)
  end

  def test_it_exists
    assert_instance_of Server, server
  end

  def test_it_contains_a_router
    assert_instance_of Router, server.router
  end

  def test_client_is_nil_by_default
    assert_nil server.client
  end

  def test_it_has_empty_request_lines_by_default
    assert_equal [], server.lines
  end

  def test_when_started_server_is_not_closed
    refute server.closed?
  end
end
