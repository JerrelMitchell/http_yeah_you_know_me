require './lib/output'

class Router
  attr_reader :server, :output
  def initialize(server)
    @server = server
    @output = Output.new(server)
  end

  def find_verb
    server.lines[0].split[0]
  end

  def path
    server.lines[0].split[1]
  end

  def verb_router
    known_post_path? if find_verb == 'POST'
    known_get_path?  if find_verb == 'GET'
  end

  def word
    path.split('=')[1]
  end

  def output_for_get_path
    output.debug_message     if path == '/'
    output.hello_message     if path == '/hello'
    output.datetime_message  if path == '/datetime'
    output.shutdown_message  if path == '/shutdown'
    output.word_search(word) if path.start_with?('/word_search')
    output.game_info         if path == '/game'
  end

  def known_get_path?
    if path == '/' ||
       path == '/hello' ||
       path == '/datetime' ||
       path == '/shutdown' ||
       path == '/game' ||
       path.start_with?('/word_search')
      output_for_get_path
    else
      output.unknown_path_message
    end
  end

  def output_for_post_path
    if path == '/start_game'
      output.start_game
    elsif path == '/game'
      output.record_guess
    else
      output.error_message
    end
  end

  def known_post_path?
    if path == '/start_game' || path == '/game'
      output_for_post_path
    else
      output.unknown_path_message
    end
  end
end
