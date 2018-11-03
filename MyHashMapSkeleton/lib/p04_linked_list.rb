
require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    # debugger
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end



class LinkedList
  
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def each
    current_node = @head.next
    until current_node.next == nil
      yield(current_node) if block_given?
      current_node = current_node.next
    end
  end
  
  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
  end

  def append(key, val)
    next_node = Node.new(key, val)
    if empty?
      next_node.prev = @head
      next_node.next = @tail
      @head.next = next_node
      @tail.prev = next_node
    else
      prev_node = last
      prev_node.next = next_node
      next_node.next = @tail
      @tail.prev = next_node
    end
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    current_node = 0
    self.each do |node|
      current_node = node if key == node.key
    end
    
    current_node.next.prev = current_node.prev if current_node.next
    current_node.prev.next = current_node.next if current_node.prev
    current_node.next = nil
    current_node.prev = nil  
    
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
