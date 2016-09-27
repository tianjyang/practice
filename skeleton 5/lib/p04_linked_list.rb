class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @first = nil
    @last = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first
  end

  def last
    @last
  end

  def empty?

  end

  def get(key)
    current_link = @first
    until current_link.nil? ||current_link.key == key
      current_link = current_link.next
    end
    current_link ? current_link.val : nil
  end

  def include?(key)
    link_to_find = @first
    until link_to_find.nil? || link_to_find.key == key
      link_to_find = link_to_find.next
    end
    link_to_find ? true : false

  end

  def insert(key, val)
    temp = Link.new(key,val)
    if @first
      @last.next = temp
      temp.prev = @last
      @last = temp
    else
      @first = temp
      @last = temp
    end
  end

  def remove(key)
    link_to_remove = @first
    until link_to_remove.nil? || link_to_remove.key == key
      link_to_remove = link_to_remove.next
    end

    # if link_to_remove == @first
    #   link_to_remove.next.prev = nil
    #   @first = link_to_remove.next
    # elsif link_to_remove == @last
    #   link_to_remove.prev.next = nil
    #   @last = link_to_remove.prev
    # else
    #   link_to_remove.prev.next = link_to_remove.next
    #   link_to_remove.next.prev = link_to_remove.prev
    # end
    if link_to_remove
      if link_to_remove.prev
        link_to_remove.prev.next = link_to_remove.next
      else
        link_to_remove.next = nil
        @first = link_to_remove.next
      end
      if link_to_remove.next
        link_to_remove.next.prev = link_to_remove.prev
      else
        link_to_remove.prev = @last
        @last.next = nil
      end
      return link_to_remove.val
    end
    nil
  end

  def each
    link_to_enum = @first
    until link_to_enum.nil?
      yield(link_to_enum)
      link_to_enum = link_to_enum.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
