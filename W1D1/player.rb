class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_guess
    puts "Player #{@name}, add a letter:"
    gets.chomp
  end


end
