require './lib/server'
require './lib/request_counter'

server = Server.new
request = RequestCounter.new

server.start
puts "Ready for a request..."
server.request_lines

request.add_request

puts "Got this request:"
puts server.lines.inspect

puts "Sending response..."
server.response(server.request_lines.join)

server.add_output(server.hello_response(request.count))
server.headers.join("\r\n")
server.socket.puts server.headers(server.output)
server.socket.puts server.output
server.socket.puts server.footers

puts ["Wrote this response: ", server.headers, server.output].join("\n")
server.socket.close
puts "\nResponse complete, exiting..."
