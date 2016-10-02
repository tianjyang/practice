require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    new_index = QuickSort.partition(array,start,length,&prc)
    left_length = new_index - start
    right_length = length - new_index - 1
    sort2!(array,start,left_length,&prc)
    sort2!(array,new_index +1 , right_length ,&prc)
    array
  end

  def self.partition(array, start, length = array.length, &prc)
    prc ||= Proc.new {|x,y| x <=> y}
    pivot_idx = start
    (start...start+length).each do |x|
      unless x == start
        if prc.call(array[pivot_idx],array[x]) == 1
          temp = array[x]
          array[x] = array[pivot_idx + 1]
          array[pivot_idx + 1] = array[pivot_idx]
          array[pivot_idx] = temp
          pivot_idx += 1
        end
      end
    end
    pivot_idx
  end

  # def self.partition(array, start, length = array.length, &prc)
  #   puts "partitioning!"
  #   return start if length <= 1
  #   array_to_part = array.slice!(start,length)
  #
  #
  #   new_idx = 0
  #   prc ||= Proc.new {|x,y| x <=> y}
  #   pivot = array_to_part[0]
  #   left = []
  #   right = []
  #   array_to_part.each_with_index do |x,idx|
  #     if idx != start
  #       result = prc.call(pivot,x)
  #       if result == 1
  #         left = left << x
  #         new_idx += 1
  #       elsif result == -1
  #         right = right << x
  #       end
  #     end
  #   end
  #   array_to_insert = left + [pivot] + right
  #   array.insert(start,*array_to_insert)
  #   new_idx + start
  # end
end
