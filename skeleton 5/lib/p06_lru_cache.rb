require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    puts "@map.include? #{@map.include?(key)} key is #{key}"
    if @map.include?(key)
      current_link = @map.get(key)
      update_link!(current_link)
      return current_link.val
    else
      if count >= @max
        eject!
      end
      puts "prc being called with #{key}"
      val = @prc.call(key)
      @map.set(key,@store.insert(key,val))
      val
      puts "after prc is called, check if map includes #{@map.include?(key)}"
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # key = link.key
    # val = link.val
    # @map.delete(key)
    # @store.remove(key)
    # @map.set(key,@store.insert(key,val))
  end

  def eject!
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
  end
end
