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
end
