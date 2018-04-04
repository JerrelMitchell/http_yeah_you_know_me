module ServerMessages
  def hello_response
    "\nHello World! (#{@count})"
  end

  def headers
    ['http/1.1 200 ok']
  end
end
