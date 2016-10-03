class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil

  end
end

class BinarySearchTree
  def initialize

  end

  def insert(value)
    if @root
      if value <= @root.value
        new_left = BinarySearchTree.insert!(@root.left,value)
        @root.left = new_left
      else
        new_right = BinarySearchTree.insert!(@root.right,value)
        @root.right = new_right
      end
    else
      @root = BSTNode.new(value)
    end
    @root
  end

  def find(value)
    BinarySearchTree.find!(@root,value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)

  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    if @root.left
      return BinarySearchTree.min(@root.left)
    end
    return @root
  end

  def max
    if @root.right
      return BinarySearchTree.max(@root.right)
    end
    return @root

  end

  def delete(value)
    BinarySearchTree.delete!(@root,value)

  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?
    if node.value >= value
      new_left = BinarySearchTree.insert!(node.left,value)
      node.left ||= new_left
    else
      new_right = BinarySearchTree.insert!(node.right,value)
      node.right ||= new_right
    end
    return node


  end

  def self.find!(node, value)
    return node if node.nil?
    if node.value == value
      return node
    elsif node.value >= value
      return BinarySearchTree.find!(node.left,value)
    else
      return BinarySearchTree.find!(node.right,value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    output = []
    output.push node.value
    if node.left
      output.concat(BinarySearchTree.preorder!(node.left))
    end
    if node.right
      output.concat(BinarySearchTree.preorder!(node.right))
    end
    return output
  end

  def self.inorder!(node)
    return [] unless node
    output = []
    if node.left
      output.concat(BinarySearchTree.inorder!(node.left))
    end
    output.push node.value
    if node.right
      output.concat(BinarySearchTree.inorder!(node.right))
    end
    return output
  end

  def self.postorder!(node)
    return [] unless node
    output = []
    if node.left
      output.concat(BinarySearchTree.postorder!(node.left))
    end
    if node.right
      output.concat(BinarySearchTree.postorder!(node.right))
    end
    output.push node.value
    return output
  end

  def self.height!(node)
    return -1 if node.nil?
    return 0 if node.left.nil? && node.right.nil?
    left_depth = BinarySearchTree.height!(node.left)
    right_depth = BinarySearchTree.height!(node.right)
    return [left_depth,right_depth].max + 1
  end

  def self.max(node)
    if node.right
      return BinarySearchTree.max(node.right)
    end
    return node
  end

  def self.min(node)
    return nil unless node
    if node.left
      return BinarySearchTree.min(node.left)
    end
    return node
  end

  def self.delete_min!(node)
    return nil unless node
    if node.left.nil?
      return node.right
    else
      node.left = BinarySearchTree.delete_min!(node.left)
    end
    return node
  end

  def self.delete!(node, value)
    return nil unless node
    if node.value == value
      return node.left unless node.right
      return node.right unless node.left
      replacement_node = BinarySearchTree.delete_min!(node.right)
      replacement_node.left = node.left
      replacement_node.right = node.right
      node = replacement_node
    elsif node.value >= value
      node.left = BinarySearchTree.delete!(node.left,value)
    else
      node.right = BinarySearchTree.delete!(node.right,value)
    end
  end
end
