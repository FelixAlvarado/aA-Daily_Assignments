require_relative 'game.rb'

class HumanPlayer

  attr_reader :name
  def initialize(name = "John")
    @name = name
  end

  def make_guess(board)
    parse(gets.chomp)
  end
  def parse(input)
    [input[0].to_i, input[-1].to_i]
  end



end
