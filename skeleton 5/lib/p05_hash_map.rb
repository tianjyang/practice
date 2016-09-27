require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  def each(&block)

  end
  attr_reader :count, :keys

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @keys = []
  end

  def include?(key)
    current_link_list = @store[key.hash % @store.length]
    current_link_list.include?(key)
  end

  def set(key, val)
    current_link_list = @store[key.hash % @store.length]
    if current_link_list.include?(key)
      current_link_list.remove(key)
      current_link_list.insert(key,val)
    else
      if @count > @store.length
        resize!
      end
      @count += 1
      @keys << key
      current_link_list.insert(key,val)
    end
  end

  def get(key)
    @store[key.hash % @store.length].get(key)
  end

  def delete(key)
    @count -= 1
    current_link_list = @store[key.hash % @store.length]
    current_link_list.remove(key)
    @keys.delete(key)

  end

  def each
    @keys.each do |key|
      yield(key,self.get(key))
    # @store.each do |current_link_list|
    #   current_link_list.each do |current_link|
    #     yield(current_link.key, current_link.val)
    #   end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    all_key_vals = []
    self.each do |key,val|
      all_key_vals << [key,val]
    end
    @store = Array.new(2*@store.length) { LinkedList.new }
    @keys = []
    @count = 0
    all_key_vals.each do |x|
      self.set(x[0],x[1])
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
