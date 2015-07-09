require_relative '00_tree_node'
class KnightPathFinder
  attr_reader :start

  def initialize(start)
    @start = start
    @visited_positions = [start]
    build_move_tree
  end

  def self.valid_moves(pos)
    row,col = pos

    valid_moves = [[row-2,col-1],[row-2,col+1],[row-1,col+2],[row+1,col+2],
    [row+2,col-1], [row+2,col+1],[row-1,col-2],[row+1, col-2]]


    valid_moves.delete_if do |space|
      !space[0].between?(0,7) || !space[1].between?(0,7)
    end

    valid_moves
  end

  def new_move_positions(pos)
    available_moves = KnightPathFinder::valid_moves(pos)

    available_moves.delete_if {|move| @visited_positions.include?(move) }

    @visited_positions.concat(available_moves)

    available_moves
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(start)

    queue = []
    queue << @root_node

    until queue.empty?
      check = queue.shift
      new_move_positions(check.value).each do |child|
        PolyTreeNode.new(child).parent=(check)
        #check.add_child(PolyTreeNode.new(child))
      end

      queue.concat(check.children)
    end
  end

  def find_path(end_pos)
    @root_node.dfs(end_pos).trace_path_back.reverse.unshift(start)
  end

end

a = KnightPathFinder.new([0,0])
p a.find_path([6,5])
