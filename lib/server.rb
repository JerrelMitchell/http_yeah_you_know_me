require './lib/server_messages'
require 'socket'

class Server
  include ServerMessages
  attr_reader :server, :connection, :lines
  def initialize(port)
    @server     = TCPServer.new(port)
    @connection = 'off'
    @lines      = []
    @count      = 0
  end

  def connect
    @connection = server.accept
  end

  def request_lines(connection)
    line = connection.gets.chomp
    until line.empty?
      line = connection.gets.chomp
      @lines << line
    end
  end

  def close
    @connection.close
  end

  def add_request
    @count += 1
  end

  def start
    loop do
      connect
      request_lines(connection)
      connection.puts headers
      connection.puts hello_response
      connection.puts requested_info
      close
      add_request
    end
  end

  def path_conditional(path)
    if path == '/'
      requested_info
    elsif path == '/hello'
      hello_response
    elsif path == '/datetime'
      "datetime 11:07AM on Sunday, November 1, 2015"
    elsif path == '/shutdown'
      "Total Requests: #{@count}" && exit
    end
  end

  # If they request the root, aka /, respond with just the debug info from Iteration 1.
  # If they request /hello, respond with “Hello, World! (0)” where the 0
  # increments each time the path is requested, but not when any other path is requested.
  # If they request /datetime, respond with today’s date and time in this format: 11:07AM on Sunday, November 1, 2015.
  # If they request /shutdown, respond with “Total Requests: 12” where 12 is
  # the aggregate of all requests. It also causes the server to exit / stop serving requests.


end
