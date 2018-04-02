class RequestCounter
  attr_reader :count
  def initialize(count = 0)
    @count = count
  end

  def add_request
    @count += 1
  end
end
