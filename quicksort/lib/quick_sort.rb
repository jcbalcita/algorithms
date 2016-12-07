class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?

    pivot = array.first

    left = array.select { |el| el <= pivot }
    right = array.select { |el| el > pivot }

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 1

    prc ||= Proc.new { |x, y| x <=> y }
    pivot_idx = partition(array, start, length, &prc)

    left = pivot_idx - start
    right = length - (left + 1)

    sort2!(array, start, left, &prc)
    sort2!(array, pivot_idx + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot_idx = start
    pivot_val = array[start]

    ((start + 1)...(start + length)).each do |i|
      current_val = array[i]
      if prc.call(pivot_val, current_val) > 0
        array[i] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot_val
        array[pivot_idx] = current_val

        pivot_idx += 1
      else
      end
    end

    pivot_idx
  end

end
