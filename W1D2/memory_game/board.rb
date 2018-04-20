require_relative 'card.rb'
require_relative 'game.rb'

require 'pry'

class Board
  attr_accessor :board

  def initialize(board = Array.new(6) {Array.new(6)})
    @board = board

  end

  def populate
    number_of_pairs = @board.flatten.length / 2
    number_of_pairs = (1..number_of_pairs).to_a.shuffle
    counter = 0
    @board.each_with_index do |row, idx|
      row.each_with_index do |pos, idx2|

        @board[idx][idx2] = Card.new(number_of_pairs[counter])
        counter += 1
        if counter > number_of_pairs.length - 1
          counter = 0
          number_of_pairs.shuffle!
        end
      end
    end
    @board
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @board[row][col] = mark
  end

  def render
    @board.each.with_index do |row, idx|
      print "| "
      row.each_index do |col|
        if @board[idx][col].exposed?
          print "#{@board[idx][col].face_value} | "
        else
          print "X | "
        end
      end
      print idx == (@board.length - 1) ? "\n" : "\n--------------\n"
    end

  end

  def won?
    @board.flatten.all? {|el| el.exposed?}
  end

  def show(pos)
    unless self[pos].exposed?
      self[pos].reveal
      self[pos].face_value
    end
  end

end
