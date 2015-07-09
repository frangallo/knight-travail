

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  def inspect
    @value
  end
  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    parent.children.delete(self) unless @parent == nil
    @parent = node
    @parent.children << self unless @parent == nil
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child)
    if !self.children.include?(child) && child
      raise "Error"
    end
    child.parent = nil
  end

  def dfs(target_value)
    if self.value == target_value
      return self
    end

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?
      check = queue.shift
      if check.value == target_value
          return check
      end
      queue.concat(check.children)
    end
    nil
  end

  def trace_path_back
    result = []
    node = self
    #debugger
    until node.parent.nil?
      result << node.value
      node = node.parent
    end
    result
  end

end
