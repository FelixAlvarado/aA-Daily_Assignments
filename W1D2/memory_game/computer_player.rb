require_relative 'game.rb'
require_relative 'board.rb'
require 'pry'
class ComputerPlayer

  attr_reader :board

  def initialize(name = "Computer")
    @name = name
    @known_cards = {}
    @matched_cards = []
    @count = "up"
  end

  def make_guess(board)
    if @matched_cards.length == 2
      @count = "down"
      face_value = @matched_cards.shift
      return @known_cards[face_value][0]
    elsif @matched_cards.length == 1 && @count == "down"
      @count = "up"
      face_value = @matched_cards.shift
      return @known_cards[face_value][1]
    end
    row, col = 0, 0
    while board[row][col].exposed?
      row = rand(board.length)
      col = rand(board.length)
    end
    receive_revealed_card([row,col], board)
    [row,col]
  end

  def receive_revealed_card(pos, board)
    value = board[pos[0]][pos[1]].face_value
    if @known_cards[value]
      @known_cards[value] << pos unless @known_cards.values.include?([pos])
    else
      @known_cards[value] = [pos]
    end
    if @known_cards[value].length == 2
      receive_match(value)
    end
  end

  def receive_match(face_value)
    @matched_cards = [face_value, face_value]
  end

end
