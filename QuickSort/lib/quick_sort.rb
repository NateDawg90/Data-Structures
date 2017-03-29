require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(arr)
    return arr if arr.empty?


    new_piv = rand(arr.length)
    arr[0], arr[new_piv] = arr[new_piv], arr[0]

    piv = arr.first

    left = arr.select { |el|  el < piv }
    middle = arr.select { |el| piv == el }
    right = arr.select { |el| el > piv }

    sort1(left) + middle + sort1(right)
  end

  # In-place. Uses O(log(n)) space for recursion.
  def self.sort2!(arr, start = 0, length = arr.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return arr if length < 2

    piv_idx = partition(arr, start, length, &prc)

    left_length = piv_idx - start
    right_length = length - (left_length + 1)
    sort2!(arr, start, left_length, &prc)
    sort2!(arr, piv_idx + 1, right_length, &prc)

    arr
  end

  def self.partition(arr, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # To reduce probability of pathalogically bad data set, shuffle piv.
    # new_piv = start + rand(length)
    # arr[start], arr[new_piv] = arr[new_piv], arr[start]

    piv_idx = start
    piv = arr[start]

    ((start + 1)...(start + length)).each do |idx|
      if prc.call(piv, arr[idx]) > 0
        arr[idx], arr[piv_idx + 1] = arr[piv_idx + 1], arr[idx]
        piv_idx += 1
      end
    end
    arr[start], arr[piv_idx] = arr[piv_idx], arr[start]



    piv_idx
  end
end
