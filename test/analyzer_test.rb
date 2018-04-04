require 'minitest/autorun'
require 'minitest/pride'
require './lib/analyzer'
require 'pry'

class AnalyzerTest < Minitest::Test
  attr_reader :analyzer
  def setup
    @analyzer = Analyzer.new
    @lines = %(Verb: GET
        Path: /
        Protocol: HTTP/1.1
        Host: 127.0.0.1
        Port: 9292
        Origin: 127.0.0.1
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9
        image/webp,*/*;q=0.8)
    analyzer.pair_data(@lines)
  end

  def test_it_exists
    assert_instance_of Analyzer, analyzer
  end

  def test_it_can_get_the_verb_value
    assert_equal 'GET', analyzer.data['Verb']
  end

  def test_it_can_get_the_path_value
    assert_equal '/', analyzer.data['Path']
  end

  def test_it_can_get_the_protocol_value
    assert_equal 'HTTP/1.1', analyzer.data['Protocol']
  end

  def test_it_can_get_the_host_value
    assert_equal '127.0.0.1', analyzer.data['Host']
  end

  def test_it_can_get_the_port_value
    assert_equal '9292', analyzer.data['Port']
  end

  def test_it_can_get_the_origin_value
    assert_equal '127.0.0.1', analyzer.data['Origin']
  end

  def test_it_can_get_the_accept_value
    expected = 'text/html,application/xhtml+xml,'\
    'application/xml;q=0.9 image/webp,*/*;q=0.8'
    assert_equal expected, analyzer.data['Accept']
  end

  def test_it_has_access_to_requested_info
    expected = %(
    <pre>
    Verb: #{analyzer.data['Verb']}
    Path: #{analyzer.data['Path']}
    Protocol: #{analyzer.data['Protocol']}
    Host: #{analyzer.data['Host']}
    Port: #{analyzer.data['Port']}
    Origin: #{analyzer.data['Origin']}
    Accept: #{analyzer.data['Accept']}
    </pre>)
    assert_equal expected, analyzer.diagnostic_info
  end
end
