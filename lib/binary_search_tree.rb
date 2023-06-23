require_relative 'node'

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

  def insert(node, key)
    return Node.new(key) if node.nil?

    if key < node.data
      node.left_child = insert(node.left_child, key)
    elsif key > node.data
      node.right_child = insert(node.right_child, key)
    end
    node
  end

  def delete(node, key)
    return node if node.nil?

    if node.data > key
      node.left_child = delete(node.left_child, key)
      node
    elsif node.data < key
      node.right_child = delete(node.right_child, key)
      node
    elsif node.left_child.nil?
      temp = node.right_child
      temp
    elsif node.right_child.nil?
      temp = node.left_child
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

  def find(node, value)
    return node if node.data == value

    if value < node.data
      find(node.left_child, value)

    elsif value > node.data
      find(node.right_child, value)
    end
  end

  def level_order

    queue = [@root]
    result = []
    
    while queue.length > 0

      if block_given?
        yield queue[0]
      else
        result << queue[0].data
      end

      if !queue[0].left_child.nil?
        queue.push(queue[0].left_child)
      end

      if !queue[0].right_child.nil?
        queue.push(queue[0].right_child)
      end

      queue.shift
    end
    result unless result.empty?
  end

  def inorder(tree = @root, arr = [], &block)
    return if tree.nil?

    inorder(tree.left_child, arr, &block)
    yield tree if block_given?
    arr << tree.data
    inorder(tree.right_child, arr, &block)
    arr
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)

#p tree.pretty_print

tree.inorder {|num| puts num.data * 2}
#tree.level_order { |node| puts node.data}
# tree.insert(tree.root, 30)
# tree.delete(tree.root, 3)
# p tree.find(tree.root, 67)
