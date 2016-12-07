require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    @store.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)

  end

  # O(n): has to shift over all the elements.
  def shift

  end

  # O(n): has to shift over all the elements.
  def unshift(val)

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    
  end
end
