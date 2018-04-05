require './lib/server'
require './lib/game'

class OutputMessages
  attr_reader :server, :hello_count, :game_count, :message, :status_code
  def initialize(server)
    @server      = server
    @hello_count = 0
    @game_count  = 0
    @game        = nil
    @message     = nil
    @status_code = nil
  end

  def client_outputs
    server.client.puts headers
    server.client.puts debug_information
  end

  def current_time
    Time.now.strftime('%l:%M%p on %A, %B %-d, %Y.')
  end

  def headers
    ["http/1.1 #{@status_code}\r\n\r\n"].join("\r\n")
  end
end
