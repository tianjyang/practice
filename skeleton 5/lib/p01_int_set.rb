class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] ||= true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_bucks = num_buckets
  end

  def insert(num)
    @store[num % @num_bucks ] << num
  end

  def remove(num)
    @store[num % @num_bucks ].delete(num)
  end

  def include?(num)
    @store[num % @num_bucks ].include?(num)
  end

  # private

  def [](num)
    @store[num % @num_bucks ]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_bucks = num_buckets
    @count = 0
  end

  def insert(num)
    if @count >= @num_bucks
      resize!
    end
    @store[num % @num_bucks ] << num
    @count += 1
  end

  def remove(num)
    @store[num % @num_bucks ].delete(num)
    @count-=1
  end

  def include?(num)
    @store[num % @num_bucks ].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count > @num_bucks
      temp = @store.flatten
      @num_bucks *= 2
      @store = Array.new(@store.length*2) {Array.new}
      temp.each do |x|
        self.insert(x)
      end
    end
  end
end
