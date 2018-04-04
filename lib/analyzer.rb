class Analyzer
  attr_reader :verb, :path, :protocol,
              :host, :port, :origin,
              :accept

  def initialize(response_data)
    @verb     = response_data.split[1]
    @path     = response_data.split[3]
    @protocol = response_data.split[5]
    @host     = response_data.split[7]
    @port     = response_data.split[9]
    @origin   = @host
    # @accept   = response_data.find do |item|
    #   item.start_with?('Accept:')
    # end.split[1]
  end
end
