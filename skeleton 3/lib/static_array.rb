# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length,nil)
    @length = length
  end

  # O(1)
  def [](index)
    return nil if index > @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    return nil if index > @length
    @store[index] = value
  end

  # protected
  attr_accessor :store
end
