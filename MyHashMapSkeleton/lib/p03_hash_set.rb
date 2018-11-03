require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count
  attr_accessor :num_buckets, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    insert_num(key) unless include?(key)
    resize! if @count == @num_buckets  
  end

  def include?(key) 
    self[key].include?(key)
  end

  def remove(key)
    remove_num(key) if include?(key)
  end

  private

  def [](key)
    location = key.hash % num_buckets
    @store[location]
  end
  
  def insert_num(key)
    self[key] << key 
    @count += 1
  end
  
  def remove_num(key)
    self[key].delete(key)
    @count -= 1
  end

  def num_buckets
    @store.length
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
