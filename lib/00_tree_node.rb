class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize (value = nil)
    @value, @parent, @children = value, nil, []
  end

  def parent=(node)
    if @parent
      @parent.children.delete(self)
    end
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(child)
    @children << child unless @children.include?(child)
    child.parent = self
  end

  def remove_child(child)
    raise "you're not my child" unless @children.include?(child)
    @children.delete(child)
    child.parent = nil
  end

  def dfs(search)
    return self if search == self.value

    @children.each do |child|
      c = child.dfs(search)
      return c unless c.nil?
    end

    nil
  end

  def bfs(search)
    queue = [self]
    until queue.empty?
      current_search = queue.shift
      return current_search if search == current_search.value
      queue += current_search.children
    end
    nil
  end

  # TODO add orphan method
end
