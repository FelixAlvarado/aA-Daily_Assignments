require_relative "player.rb"
require "byebug"
class Game
  GHOST = {0 => 'no loses', 1 => 'G', 2 => 'GH', 3 => 'GHO', 4 => 'GHOS', 5 => 'GHOST'}
attr_reader :dictionary, :continue
  def initialize(players = { p1: Player.new("Jhon"), p2: Player.new("Mark")})
    @player1 = players[:p1]
    @player2 = players[:p2]
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @fragment = ""
    @curr_player = @player1
    @loses = {p1:0 , p2:0}
    @continue = true
  end

  def play_round
    word = @fragment +  @curr_player.get_guess
    if valid_play?(word)
      @fragment = word
      if valid_word?
      puts "#{@curr_player.name} wins, continue playing"
      add_ghost
      end
      puts @fragment
      switch_players
    else
      game_over
    end

  end


  def add_ghost
    if @curr_player == @player1
      @loses[:p2] += 1
      puts "#{@player2.name} now has #{GHOST[@loses[:p2]]}"
    else
        @loses[:p1] += 1
          puts "#{@player1.name} now has #{GHOST[@loses[:p1]]}"
    end
    if @loses[:p2] == 5 || @loses[:p1] == 5
      @continue = false
      game_over(true)
    end
  end

  def valid_word?
    @dictionary.include?(@fragment)
  end

  def valid_play?(word)
    @dictionary.any?{|entry|  entry[0..word.length - 1] == word  }
  end

  def switch_players
    if @curr_player == @player1
      @curr_player = @player2
    else
      @curr_player = @player1
    end

  end

  def game_over(boolean = false)
    if boolean
      puts "#{@curr_player.name} loses!! They have #{GHOST[@loses[:p1]]} " if @curr_player == @player1
      puts "#{@curr_player.name} loses!! They have #{GHOST[@loses[:p2]]} " if @curr_player == @player2
    else
    switch_players
    puts "#{@curr_player.name} wins!!!"
    puts "#{@fragment} was the last play"
  end

end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  p game.dictionary.length
  while game.continue
    game.play_round
  end
end
