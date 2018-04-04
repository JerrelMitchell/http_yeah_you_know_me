require 'socket'

class Server
  attr_reader :server, :connection, :lines
  def initialize(port)
    @server        = TCPServer.new(port)
    @connection    = connection
    @lines         = []
    @count = 0
  end

  def request_lines(connection)
    line = connection.gets.chomp
    until line.empty?
      line = connection.gets.chomp
      @lines << line
    end
  end

  def connect
    @connection = server.accept
  end

  def close
    @connection.close
  end

  def add_request
    @count += 1
  end

  def hello_response
    "\nHello World! (#{@count})"
  end

  def headers
    ['http/1.1 200 ok']
  end

  def requested_info
    %(Verb: POST\n
      Path: /\n
      Protocol: HTTP/1.1\n
      Host: 127.0.0.1\n
      Port: 9292\n
      Origin: 127.0.0.1\n
      Accept: text/html,application/xhtml+xml,application/xml;q=0.9\n
      image/webp,*/*;q=0.8\n)
  end

  def server_loop
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
end
