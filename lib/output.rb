require './lib/game'

class Output
  attr_reader :server, :count, :hello_count, :game_count,
              :message, :status_code, :current_time, :dictionary
  def initialize(server)
    @server       = server
    @count        = 0
    @hello_count  = 0
    @game_count   = 0
    @game         = nil
    @message      = nil
    @status_code  = nil
    @current_time = Time.now.strftime('%l:%M%p on %A, %B %-d, %Y.')
    @dictionary   = File.read('/usr/share/dict/words')
  end

  def client_outputs
    @count += 1
    server.client.puts headers
    server.client.puts debug_information
  end

  def headers
    ["http/1.1 #{@status_code}\r\n\r\n"].join("\r\n")
  end

  def debug_message
    @status_code = '200 OK'
    @message = ''
    client_outputs
  end

  def hello_message
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
    client_outputs
    server.close = true
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

  def word_error_message
    "Invalid input. Search by typing in the path '/word_search=your_word_here'"
  end

  def word_search(word)
    @status_code = '200 OK'
    if word.nil?
      @message = word_error_message
    elsif dictionary.include?(word)
      @message = "#{word.upcase} is a known word."
    else
      @message = "#{word.upcase} is not a known word."
    end
    client_outputs
  end

  def start_game
    @status_code = '301 Moved Permanently' if @game.nil?
    @game        = Game.new(server)
    @message     = 'Good luck!'
    client_outputs
  end

  def request_guess
    @message = 'Enter a VALID whole number between 0 and 100...'
  end

  def correct_guess(guess)
    @message = "#{guess} was a good guess. You win! Congratulations!"
  end

  def guess_too_high(guess)
    @message = "#{guess}? Too high. Try again."
  end

  def guess_too_low(guess)
    @message = "#{guess}? Too low. Try again."
  end

  def game_error_message
    %(You have not started a game, or you have not made any guesses.
      Please start a game by posting to the path '/start_game'.)
  end

  def content_length
    server.lines.find do |line|
      line.include?('Content')
    end.split(' ')[1].to_i
  end

  def record_guess
    @status_code = '200 OK'
    @game_count += 1
    guess        = server.client.read(content_length)
    input        = guess.split[-2].to_i
    @game.compare_numbers(input)
  end

  def game_info
    @status_code = '200 OK'
    @message     = game_error_message if @game_count.zero?
    @message     = "You've made #{@game_count} guess(es)!"
    client_outputs
  end
end
