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

  def debug_message
    @status_code = '200 OK'
    @message = ''
    client_outputs
  end

  def hello_world_message
    @status_code  = '200 OK'
    @hello_count += 1
    @message      = "Hello, World! (#{hello_count})"
    client_outputs
  end

  def datetime_message
    @status_code = '200 OK'
    @message     = current_time
    client_outputs
  end

  def shutdown_message
    @status_code = '200 OK'
    @message     = "Total Requests: #{count}"
    server.close = true
    client_outputs
  end

  def unknown_path_message
    @status_code = '404 Not Found'
    @message     = 'Unknown Path'
    client_outputs
  end

  def debug_information
    %(#{@message}
    Verb:     #{server.lines[0].split[0]}
    Path:     #{server.lines[0].split[1]}
    Protocol: #{server.lines[0].split[2]}
    Host:     #{server.lines[1].split[1].split(':')[0]}
    Port:     #{server.lines[1].split[1].split(':')[1]}
    Origin:   #{server.lines[1].split[1].split(':')[0]})
  end

  def word_search
    @status_code = '200 OK'
    word = path.split('=')[1]
    if File.read('/usr/share/dict/words').include?(word)
      @message = "#{word.upcase} is a known word."
    else
      @message = "#{word.upcase} is not a known word."
    end
    output
  end
end
