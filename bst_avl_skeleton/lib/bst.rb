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
    @root = nil
  end

  def insert(value)
    if !@root
      @root = BSTNode.new(value)
      return
    end

    BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
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
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if !node

    if node.value >= value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end

    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if value < node.value
      BinarySearchTree.find!(node.left, value)
    else
      BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    preordered = [node.value]

    preordered += BinarySearchTree.preorder!(node.left) if node.left
    preordered += BinarySearchTree.preorder!(node.right) if node.right

     preordered
  end

  def self.inorder!(node)
    return [] if !node
    ordered = []

    ordered += BinarySearchTree.inorder!(node.left) if node.left
    ordered << node.value
    ordered += BinarySearchTree.inorder!(node.right) if node.right

    ordered
  end

  def self.postorder!(node)
    return [] if !node
    postordered = []

    postordered += BinarySearchTree.postorder!(node.left) if node.left
    postordered += BinarySearchTree.postorder!(node.right) if node.right
    postordered << node.value
  end

  def self.height!(node)
    return -1 if !node

    left = BinarySearchTree.height!(node.left)
    right = BinarySearchTree.height!(node.right)

    higher = left > right ? left : right

    1 + higher
  end

  def self.max(node)
    return node if !node.right

    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return node if !node.left

    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil if !node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil if !node

    if node.value > value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif node.value < value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left

      temp = node
      node = temp.right.min
      node.right = BinarySearchTree.delete_min!(temp.right)
      node.left = temp.left
    end

  end
end
