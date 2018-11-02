class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |el, idx|
      res += el.hash * idx.hash
    end
    res
  end
end

class String
  def hash(alphabet = ("a".."z").to_a)
    self.chars.reduce(0) {|acc, el| acc += alphabet.index(el).hash * (self.index(el)+1) }    
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.values.reduce(0) {|acc, el| acc += el.hash}
  end
end
