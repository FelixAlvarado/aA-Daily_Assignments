require_relative 'tree.rb'

class KnightPathFinder

  attr_accessor :grid , :position ,:move_tree, :visited_positions
  # VALID_MOVES = [[1,2],[-1,2],[-2,1], [-2,-1],[-1,-2],[1,-2],[2,-1],[2,1]]

  def initialize(pos)
    @position = pos
    @grid = Array.new(8){Array.new(8)}
    populate_grid
    @visited_positions = [pos]
    @move_tree = build_move_tree
  end

  def valid_moves(pos)
    result = []

    [[1,2],[-1,2],[-2,1], [-2,-1],[-1,-2],[1,-2],[2,-1],[2,1]].each do |move|
      new_x , new_y = pos[0] + move[0] , pos[1] + move[1]
      new_pos = [new_x, new_y]
      result << new_pos if new_x > 0 && new_y > 0 && new_x < 8 && new_y < 8 && !@visited_positions.include?(new_pos)
    end
    result
  end

  def populate_grid
    @grid.map! do |row|
      row.map! {|pos| pos = 'x'}
    end
  end

  def new_move_positions(pos)
    moves = valid_moves(pos)

    @visited_positions << moves
    node = []
    moves.each do |move|
      node << PolyTreeNode.new(move, self, [])
    end
    node
  end


  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def build_move_tree
    PolyTreeNode.new(@position, nil , new_move_positions(@position) )
  end

end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0])
  p knight.move_tree.bfs([2,1])
end
