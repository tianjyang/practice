
class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
    return 0 if @store[0].nil?
    @store.length
  end

  def extract
    temp = @store.shift
    new_head = @store.unshift(@store.pop)
    puts @store
    self.class.heapify_down(@store,0)
    temp
  end

  def peek
  end

  def push(val)
    @store.push(val)
    index = @store.length - 1
    self.class.heapify_up(@store,index)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    first = parent_index * 2 + 1
    second = parent_index * 2 + 2
    output = [first, second]
    output.select{|num| num < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    unless prc
      prc = Proc.new{|x,y| -(x<=>y)}
    end

    heap_occurred = true
    while heap_occurred do
      heap_occurred = false
      parent = array[parent_idx]
      children = self.child_indices(len, parent_idx)
      children.each do |child_idx|
        if prc.call(parent,array[child_idx]) == -1
          array[parent_idx],array[child_idx] = array[child_idx],array[parent_idx]
          parent_idx = child_idx
          heap_occurred = true
          break
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    if child_idx == 0
      return array
    end

    unless prc
      prc = Proc.new{|x,y| -1 * (x<=>y)}
    end

    heap_occurred = true
    while heap_occurred && child_idx != 0 do
      heap_occurred = false
      child = array[child_idx]
      parent_idx = self.parent_index(child_idx)
      parent = array[parent_idx]
      if prc.call(child,parent) == 1
        array[parent_idx],array[child_idx] = array[child_idx],array[parent_idx]
        child_idx = parent_idx
        heap_occurred = true
      end
    end
    array
  end
end
