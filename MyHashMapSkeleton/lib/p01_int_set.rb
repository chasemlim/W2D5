require 'byebug'

class MaxIntSet
  attr_accessor :store
  
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    location = num % num_buckets
    @store[location] << num
  end

  def remove(num)
    location = num % num_buckets
    @store[location].delete(num)
  end

  def include?(num)
    location = num % num_buckets
    @store[location].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :num_buckets, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    insert_num(num) unless include?(num)  
    resize! if @count == @num_buckets   
  end

  def remove(num)
    remove_num(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    location = num % num_buckets
    @store[location]
  end
  
  def num_buckets
    @store.length
  end

  def insert_num(num)

    self[num] << num 
    @count += 1
  end
  
  def remove_num(num)
    self[num].delete(num)
    @count -= 1
  end
  
  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each do |el|
      self.insert(el)
      @count -= 1
    end
    @num_buckets = num_buckets * 2
  end
end
