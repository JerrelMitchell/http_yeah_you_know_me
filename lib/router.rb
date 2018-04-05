require './lib/output_messages'

class Router
  attr_reader :server, :router, :output
  def initialize(server)
    @server = server
    @output = OutputMessages.new(server)
  end

  def path
    server.lines[0].split[1]
  end

  def find_verb
    server.lines[0].split[0]
  end

  def verb_router
    known_post_path if find_verb == 'POST'
    known_get_path  if find_verb == 'GET'
  end

  def output_for_get_path
    output.debug_message       if path == '/'
    output.hello_world_message if path == '/hello'
    output.datetime_message    if path == '/datetime'
    output.shutdown_message    if path == '/shutdown'
    output.word_search         if path.start_with?('/word_search')
    output.game_info           if path == '/game'
  end

  def known_get_path
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
end
