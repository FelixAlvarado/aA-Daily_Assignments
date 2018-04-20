require_relative 'card.rb'
require_relative 'human_player.rb'
require_relative 'board.rb'
require_relative 'computer_player.rb'

class Game

  attr_accessor :board

  def initialize(board = Board.new, player_one = ComputerPlayer.new)
    @board = board
    @board.populate
    @guessed_pos = []
    @previous_guess = []
    @current_player = player_one
  end

  def play
    p @board.board
    puts "Welcome to the Memory Game!!!"
    @board.render
    count = 0
    until @board.won?
      count += 1
      sleep(0.25)
      @guessed_pos = get_guess
      @board.show(@guessed_pos)
      @board.render
      @previous_guess = get_guess
      @board.show(@previous_guess)
      @board.render
      unless matching?
        self.board[@guessed_pos].hide
        self.board[@previous_guess].hide
      end
    end
    puts "You won the game! YAYAYAYAYAYA!!!!!"
    puts "it took you #{count} moves!"
  end

  def get_guess
    guess = []
    until valid_guess?(guess)
      puts "Which card would you like: "
      guess = @current_player.make_guess(@board.board)
    end
    guess
  end

  def valid_guess?(guess)
    return false if guess == []
    if self.board[guess].exposed?
      puts "That card is already showing!!!"
      return false
    end
    true
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def matching?
    self.board[@guessed_pos].face_value == self.board[@previous_guess].face_value
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.play
end
