require_relative 'binary_search_tree'

arr = (Array.new(150) { rand(1..150) })

tree = Tree.new(arr)

tree.balanced?
p tree.level_order
p tree.postorder
p tree.preorder
p tree.inorder