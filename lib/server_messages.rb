module ServerMessages
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
end
