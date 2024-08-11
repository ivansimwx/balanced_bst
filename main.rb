require_relative "lib/tree"
require_relative "lib/node"

test = Tree.new
test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
root_node = test.build_tree(test_array)

# help: visualise binary search tree
test.pretty_print

# test insert
# test.insert(66)
# test.pretty_print

# test delete
# test.delete(7) # no child
# test.delete(1) # 1 child
# test.delete() # 2 children
# test.pretty_print

# test find
# p test.find(67)
