require_relative '00_tree_node'
require 'byebug'
class KnightPathFinder
  DELTAS = [[2, 1], [2, -1], [1, 2], [1, -2],
            [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  attr_accessor :visited_positions
  attr_reader :start

  def initialize(start)
    @start = PolyTreeNode.new(start)
    @visited_positions = [start]
  end

  def new_move_position(pos)
    moves = valid_moves(pos)
    moves.reject! { |pos| @visited_positions.include?(pos) }
    @visited_positions += moves
    moves
  end

  def valid_moves(pos)
    moves = DELTAS.map { |(dx, dy)| [dx + pos.first, dy + pos.last] }
    moves.select { |(x, y)| x.between?(0, 7) && y.between?(0, 7)}
  end

  def build_move_tree
    queue = [@start]
    #debugger

    until queue.empty?
      parent = queue.shift
      child_pos = new_move_position(parent.value)
      child_pos.each do |pos|
        orphan = PolyTreeNode.new(pos)
        orphan.parent = parent
        child = orphan
        queue << child
        #p "#{queue.map{|node| node.value }}"
      end
    end
  end

  def find_path(end_pos)
    end_node = @start.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = []
    node = end_node

    until node.parent.nil?
      path.unshift(node.value)
      node = node.parent
    end

    path.unshift(@start.value)
  end

end

if __FILE__==$0
  orphans = KnightPathFinder.new([0,0])
  orphans.build_move_tree
  p orphans.find_path([6,2])
end
