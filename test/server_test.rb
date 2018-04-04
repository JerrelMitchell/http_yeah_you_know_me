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
end
