require_relative 'knight.rb'
class PolyTreeNode


attr_accessor :value , :parent, :children

  def initialize (value,parent = nil ,children = [])

    @value = value
    @parent = parent
    @children = children

  end

  def parent=(node)

    @parent.children.delete(self) if @parent != nil && node != nil
    @parent = node
    return nil if @parent == nil
    parent.children << self unless parent.children.include?(self)

  end

  def add_child(node)

     node.parent=(self)   unless children.include?(node)

  end

  def remove_child(node)

    raise "Not a child node" unless children.include?(node)
    node.parent = nil
    children.delete(node)

  end

  def dfs(target)

    return self if target == self.value

    children.each do |child|
      result = child.dfs(target)
      return result unless result == nil
    end

    nil

  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      temp_node = queue.pop

       if target == temp_node.value
         return temp_node.value
       else
         temp_node.children.each do |child|
         queue.unshift(child)
       end
     end
     nil
    end

  end

end
