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
    if @root == nil
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
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
    return BSTNode.new(value) unless node
    if value > node.value
      node.right = self.insert!(node.right, value)
    else
      node.left = self.insert!(node.left, value)
    end

    node
  end

  def self.find!(node, value)
    # O(logn)
    return nil unless node
    return node if node.value == value
    if value > node.value
      self.find!(node.right, value)
    else
      self.find!(node.left, value)
    end

  end

  def self.preorder!(node)
    return [] unless node
    [node.value] + self.preorder!(node.left) + self.preorder!(node.right)
  end

  def self.inorder!(node)
    return [] unless node
    self.inorder!(node.left) + [node.value] + self.inorder!(node.right)
  end

  def self.postorder!(node)
    return [] unless node
     self.postorder!(node.left) + self.postorder!(node.right) + [node.value]
  end

  def self.height!(node)
    return -1 unless node
    right = self.height!(node.right) + 1
    left = self.height!(node.left) + 1
    return (right > left ? right : left)
  end

  def self.max(node)
    return nil unless node
    while node
      max = node
      node = node.right
    end

    max
  end

  def self.min(node)
    return nil unless node
    while node
      min = node
      node = node.left
    end

    min
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left
    node.left = self.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node
    return nil if node.value == value
    if value < node.value
      node.left = self.delete!(node.left, value)
    else
      node.right = self.delete!(node.right, value)
    end

    node
  end

end
