require 'socket'

class Server
  attr_reader :client, :socket, :lines
  def initialize
    @client  = client
    @socket  = socket
    @lines   = []
  end

  def start(port_number)
    @client  = TCPServer.new(port_number)
    @socket  = client.accept
  end

  def request_lines
    line = socket.gets until line.chomp.empty?
    @lines << line.chomp
  end

  def hello_response(request_count)
    "Hello World! (#{request_count})\n"
  end

  def response(info)
    "<pre>#{info}</pre>"
  end

  def add_output(output)
    "<html><head></head><body>#{output}</body></html>"
  end

  def headers(content)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{content.length}\r\n\r\n"]
  end

  def footers
    "<pre>
    Verb: POST\n
    Path: /\n
    Protocol: HTTP/1.1\n
    Host: 127.0.0.1\n
    Port: 9292\n
    Origin: 127.0.0.1\n
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,"\
    "image/webp,*/*;q=0.8\n
    </pre>"
  end
end
