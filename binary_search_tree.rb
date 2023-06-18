class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

end

class Tree
  attr_accessor :root

  def initialize(array)
    bob = array.sort.uniq
    @root = build_tree(bob)
  end

  def build_tree(array)
    return nil if array.empty?

    root = Node.new(array[array.size / 2])
    root.left_child = build_tree(array[0...array.size / 2])
    root.right_child = build_tree(array[(array.size / 2)+1..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(node,key)
    return Node.new(key) if node.nil?

    if key < node.data
      node.left_child = insert(node.left_child, key)
    elsif key > node.data
      node.right_child = insert(node.right_child, key)
    end
    node
  end

  def delete(node,key)
    return node if node.nil?

    if node.data > key
      node.left_child = delete(node.left_child, key)
      node
    elsif node.data < key
      node.right_child = delete(node.right_child, key)
      node
    elsif node.left_child.nil?
      temp = node.right_child
      node = nil
      temp
    elsif node.right_child.nil?
      temp = node.left_child
      node = nil
      temp
    else
      succ_parent = node
      succ = node.right_child
      while succ.left_child != nil
        succ_parent = succ
        succ = succ.left_child
      end
      if succ_parent != node
        succ_parent.left_child = succ.right_child
      else
        succ_parent.right_child = succ.right_child
      end
    end
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)
tree.insert(tree.root, 30)
tree.delete(tree.root, 5)

tree.pretty_print