class BinaryMinHeap
  def initialize(&prc)
    self.store = []
    self.prc = prc || Proc.new { |x, y| x <=> y }
  end

  def count
    store.length
  end

  def extract
    raise "cannot extract" if count == 0

    store[0], store[store.length - 1] = store[store.length - 1], store[0]
    popped = store.pop
    self.class.heapify_down(store, 0)
    popped
  end

  def peek
    store[0]
  end

  def push(val)
    store << val
    self.class.heapify_up(store, count - 1, count, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_idx = []
    double = parent_index * 2
    [1, 2].each { |x| child_idx << (double + x) if (double + x) < len }

    child_idx
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    first_idx, second_idx = child_indices(len, parent_idx)
    parent_val = array[parent_idx]

    child_vals = []
    child_vals << array[first_idx] if first_idx
    child_vals << array[second_idx] if second_idx

    return array if child_vals.all? { |child| prc.call(parent_val, child) <= 0 }

    swap_idx = nil
    if child_vals.length == 1
      swap_idx = first_idx
    else
      swap_idx = prc.call(child_vals[0], child_vals[1]) == -1 ? first_idx : second_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    parent_val = array[parent_idx]
    child_val = array[child_idx]

    if prc.call(child_val, parent_val) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, len, &prc)
    else
      array
    end
  end
end
