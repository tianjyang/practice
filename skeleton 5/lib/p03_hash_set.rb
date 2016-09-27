require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= @store.length
      resize!
    end
    @count += 1
    @store[key.hash % @store.length] << key
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def remove(key)
    @count -= 1
    @store[key.hash % @store.length].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.flatten
    @store = Array.new(@store.length*2) {Array.new}
    temp.each do |x|
      self.insert(x)
    end
  end
end
