require_relative 'binary_search_tree'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)

p tree.pretty_print
puts tree.depth(tree.root.left_child)
#puts tree.height(tree.root)
#tree.level_order { |node| puts node.data}
# tree.insert(tree.root, 30)
# tree.delete(tree.root, 3)
# p tree.find(tree.root, 67)