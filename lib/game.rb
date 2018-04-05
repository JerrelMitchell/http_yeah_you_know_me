class Game
  attr_reader :rand_num, :output
  def initialize(server)
    @rand_num = rand(0..100)
    @output   = Output.new(server)
  end

  def compare_numbers(input)
    if input < 0 || input > 100
      output.request_guess
    elsif input == rand_num
      output.correct_guess(input)
    elsif input > rand_num
      output.guess_too_high(input)
    elsif input < rand_num
      output.guess_too_low(input)
    end
    output.client_outputs
  end
end
