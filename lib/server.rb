require 'socket'
require './lib/router'

class Server
  attr_reader :lines, :server, :client, :router, :closed
  alias :closed? closed
  def initialize(port)
    @server = TCPServer.new(port)
    @router = Router.new(self)
    @client = nil
    @closed = false
    @lines  = []
  end

  def start
    loop do
      break if closed == true
      @client = server.accept
      @lines  = []
      request_lines
      router.verb_router
      client.close
    end
  end

  def request_lines
    while line = @client.gets and !line.chomp.empty?
      @lines << line.chomp
    end
  end
end
