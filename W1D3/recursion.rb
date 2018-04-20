require 'byebug'

def range(start,finish)
  return [] if finish <= start
  [start] + range(start + 1 , finish)
end

def inter_sum(arr)
  arr.inject(0) {|acc, el| acc + el}
end

def recur_sum(arr)
  return 0 if arr.empty?
  return arr[0] if arr.length == 1
  arr[0] + recur_sum(arr[1..-1])
end

def exp_a(base, n)
  return 1 if n == 0
  base * exp_a(base, n - 1)
end

def exp_b(base, n)
  return 1 if n == 0
  return base if n == 1

  if n.even?
    exp = exp_b(base, n / 2)
    exp * exp
  else
    exp = exp_b(base, (n - 1) / 2 )
    base * (exp * exp )
  end

end


def deep_dup(arr)
  return arr unless arr.is_a?(Array)
  arr.map do |el|
    if el.is_a?(Array)
      deep_dup(el)
    else
      el
    end
  end
end

def iter_fibonacci(n)
  return [1] if n == 1
  result = [1,1]
  while result.length < n
    result << result[-1] + result[-2]
  end
  result
end

def recursion_fibonacci(n)
  return [1] if n == 1
  return [1,1] if n == 2
  recursion = recursion_fibonacci(n - 1)
  recursion << recursion.last + recursion[-2]
end

def bsearch(arr, target)
  return nil if arr.empty?
  mid = arr.length / 2
  return mid if arr[mid] == target
  if arr[mid] < target
      search = bsearch(arr[mid + 1 ..-1], target)
      search.nil? ? nil : (mid + 1) + search
  else
    bsearch(arr[0...mid], target)
  end

end

def merge_sort(arr)
  return arr if arr.length <= 1
  left = merge_sort(arr[0...arr.length / 2])
  right = merge_sort(arr[arr.length / 2..-1])
  merge(left, right)
end

def merge(left, right)
  return left if right.empty?
  return right if left.empty?
  if left.first > right.first
    [right.first] + merge(left, right[1..-1])
  else
    [left.first] + merge(left[1..-1], right)
  end

end

def subsets(arr)
  return [arr] if arr.empty?
  # recursion = subsets(arr[0...-2])

  subsets(arr[0...-1]) + subsets(arr[0...-1]).map { |el| el.push(arr.last)}
end

def permutations(array)
  return [array] if array.length == 1
  result = []
  permutations(array[0...-1]).each do |perm|
    array.length.times do |i|
      result << perm[0...i] + [array.last] + perm[i..-1]
    end
  end
  result.sort
end

def greedy_make_change(amount, coins)
  return coins.min if coins.min > amount
  return if coins.empty?
  change = []
  coins.select{|coin| coin <= amount}.sort.reverse.each do |el|
    if el <= amount
      change.push(el)
      amount = amount - el
      break
    end
  end
  change.concat(greedy_make_change(amount, coins)) if amount > 0
  change
end

def make_better_change(amount, coins)
  return coins.min if coins.min > amount
  return if coins.empty?
  change = []
  coins.sort.reverse.each_with_index do |el, idx|
    (idx..coins.length - 1).each do |idx2|
      if coins[idx] + coins[idx2] == amount
        change << coins[idx]
        change << coins[idx2]
        return change
      end
    end

    if el <= amount
      change.push(el)
      amount = amount - el
      break
    end

  end
  p change
  change.concat(make_better_change(amount, coins)) if amount > 0
  change
end

def make_better(amount, coins)
  return [] if coins.none? {|coin| coin <= amount}
  change = []
  coins.each do |coin|
    change << [coin].concat(make_better(amount - coin, coins.select{|c| c <= coin})) if coin <= amount
  end
  change.map{|x| x.flatten}.sort_by{|x| x.length}.first
end
