require "byebug"
require_relative "heap"

class Array
  def heap_sort!
    min_heap = BinaryMinHeap.new
    until self.empty?
      min_heap.push(self.pop)
    end

    until min_heap.count == 0
      debugger
      self.push(min_heap.extract)
    end

  end
end
