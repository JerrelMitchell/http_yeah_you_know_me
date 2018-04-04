require 'minitest/autorun'
require 'minitest/pride'
require './lib/analyzer'
require 'pry'

class AnalyzerTest < Minitest::Test
  attr_reader :analyzer
  def setup
    @data = %(Verb: GET\n
        Path: /\n
        Protocol: HTTP/1.1\n
        Host: 127.0.0.1\n
        Port: 9292\n
        Origin: 127.0.0.1\n
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9\n
        image/webp,*/*;q=0.8\n)
    @analyzer = Analyzer.new(@data)
  end

  def test_it_exists
    assert_instance_of Analyzer, analyzer
  end

  def test_it_can_get_the_verb
    assert_equal 'GET', analyzer.verb
  end

  def test_it_can_get_the_path
    assert_equal '/', analyzer.path
  end

  def test_it_can_get_the_protocol
    assert_equal 'HTTP/1.1', analyzer.protocol
  end

  def test_it_can_get_the_host
    assert_equal '127.0.0.1', analyzer.host
  end

  def test_it_can_get_the_port
    assert_equal '9292', analyzer.port
  end

  def test_it_can_get_the_origin
    assert_equal '127.0.0.1', analyzer.origin
  end
end
