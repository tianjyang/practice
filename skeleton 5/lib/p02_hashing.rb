require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    output = 0
    self.each_with_index do |x,idx|
      output += x.hash * idx
    end
    output
  end
end

class String
  def hash
    output = 0
    self.split("").each_with_index do |x,idx|
      output += x.ord.hash * idx
    end
    output
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    output = 0
    self.keys.each_with_index do |x,idx|
      output += x.hash
    end
    output
  end
end
