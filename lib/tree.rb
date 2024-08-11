# setup tree class
class Tree
  attr_accessor :root

  def initialize()
    @root = nil
    @final = nil
  end

  def build_tree(array)
    array = array.uniq
    array = array.sort
    @root = recur_build(array, 0, array.length - 1)
    @root
  end

  def recur_build(array, arr_start, arr_end)
    return if arr_start > arr_end

    arr_mid = (arr_start + arr_end) / 2
    current_node = Node.new(array[arr_mid])
    current_node.left = recur_build(array, arr_start, arr_mid - 1)
    current_node.right = recur_build(array, arr_mid + 1, arr_end)
    current_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data)
    current_node = @root
    loop do
      if data < current_node.value
        if current_node.left.nil?
          current_node.left = Node.new(data)
          break
        end
        current_node = current_node.left
      elsif data > current_node.value
        if current_node.right.nil?
          current_node.right = Node.new(data)
          break
        end
        current_node = current_node.right
      end
    end
  end

  def delete(data)
    previous_node = current_node = @root
    direction = ''
    # find node
    loop do
      break if current_node.value == data

      previous_node = current_node
      if data < current_node.value
        current_node = current_node.left
        direction = 'left'
      else
        current_node = current_node.right
        direction = 'right'
      end
    end

    return if current_node.nil?

    recur_del(current_node, previous_node, direction)
  end

  # delete node if no child, 1 or 2 children
  def recur_del(current_node, previous_node, direction)
    p current_node.value
    p previous_node.value
    p direction
    if current_node.left.nil? && current_node.right.nil?
      # puts "enter 0"
      if direction == 'left'
        previous_node.left = nil
      else
        previous_node.right = nil
      end
    elsif current_node.left.nil?
      # puts "enter 1.1"
      if direction == 'left'
        previous_node.left = current_node.right
      else
        previous_node.right = current_node.right
      end
    elsif current_node.right.nil?
      # puts "enter 1.2"
      if direction == 'left'
        previous_node.left = current_node.left
      else
        previous_node.right = current_node.left
      end
    elsif current_node.left && current_node.right
      # puts "enter 2"
      next_biggest_node = current_node.right
      previous_node = current_node
      direction = 'right'
      loop do
        break if next_biggest_node.left.nil?

        previous_node = next_biggest_node
        next_biggest_node = next_biggest_node.left
        direction = 'left'
      end
      recur_del(next_biggest_node, previous_node, direction)
      current_node.value = next_biggest_node.value
    end
  end

  def find(data)
    current_node = @root
    loop do
      break if current_node.value == data

      current_node = current_node.left if data < current_node.value
      current_node = current_node.right if data >current_node.value
    end
    current_node
  end
end
