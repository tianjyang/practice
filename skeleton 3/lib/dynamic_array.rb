require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= @length
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    temp = @store[@length]
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    @length.times do |index|
      @store[index-1] = @store[index] unless index == 0
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @length.times do |index|
      @store[@length - index] = @store[@length - index -1] unless index == @length
    end
    @store[0]= val
  end


  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    temp = StaticArray.new(@capacity*2)
    @length.times do |index|
      temp[index] = @store[index]
    end
    @store = temp
    @capacity *= 2
    nil
  end
end
