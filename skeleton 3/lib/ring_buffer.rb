require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length
  # attr_reader :store, :start_idx

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[(index+@start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index >= @length
    @store[(index+@start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[( @length+@start_idx ) % @capacity]

  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[( @length+@start_idx ) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    temp = @store[@start_idx]
    @start_idx = (@start_idx+1) % @capacity
    @length -=1
    temp
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    @store[@start_idx] = val
  end

  # protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    temp = StaticArray.new(2*@capacity)
    @capacity.times do |index|
      temp[index] = self[index]
    end
    @store = temp
    @start_idx = 0
    @capacity *=2
  end
end
