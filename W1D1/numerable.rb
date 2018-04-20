require "byebug"
class Array
  def my_each(&blk)
    i = 0
    while i < self.length
      blk.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&blk)
    result = []
    self.each {|el| result << el if blk.call(el)}
    result
  end

  def my_reject(&blk)
    result = []
    self.each {|el| result << el unless blk.call(el)}
    result
  end

  def my_any?(&blk)
    self.each {|el| return true if blk.call(el)}
    false
  end

  def my_all?(&blk)
    self.each {|el| return false unless blk.call(el)}
    true
  end

  def my_flatten
    result = []
      self.each_with_index do |el, idx|
        if !el.is_a?(Array)
          result << self[idx]
        else
          result += el.my_flatten
        end
      end
      result
  end

  def my_zip(*args)
    result = []
    self.each_with_index do |el, idx|
      temp_arr = []
      temp_arr << el
      args.each {|arr| temp_arr << arr[idx]}
      result << temp_arr
    end
    result
  end

  def my_rotate(num=1)
    result = []
    num = num % self.length
     if num > 0
       result = self.drop(num) + self.take(num)
       return result
     elsif num < 0
       result = self.drop(self.length + num) + self.take(self.length + num)
       return result
     end
     self
  end

  def my_join(sep = '')
    result = ''
    self.each_with_index do |el,idx|
      result << el
       result << sep unless idx == self.length - 1
    end
    result
  end

  def my_reverse
    temp_arr = []
    self.length.times { temp_arr << self.pop}
    temp_arr
  end

  def bubble_sort!(&prc)
    until self == self.sort
      if block_given?
        self.each_with_index do |el,idx|
          if idx + 1 < self.length && prc.call(self[idx], self[idx+1]) == 1
            self[idx],self[idx +1] = self[idx + 1],self[idx]
          end
        end
      else
        self.each_with_index do |el,idx|
          if idx + 1 < self.length && self[idx +1] < self[idx]
            self[idx],self[idx +1] = self[idx + 1],self[idx]
          end
        end
      end
    end
        self
    end

    def bubble_sort(&prc)
      arr = self.dup
      until arr == arr.sort
        if block_given?
          arr.each_with_index do |el,idx|
            if idx + 1 < arr.length && prc.call(arr[idx], arr[idx+1]) == 1
              arr[idx],arr[idx +1] = arr[idx + 1],arr[idx]
            end
          end
        else
          arr.each_with_index do |el,idx|
            if idx + 1 < arr.length && arr[idx +1] < arr[idx]
              arr[idx],arr[idx +1] = arr[idx + 1],arr[idx]
            end
          end
        end
      end
          arr
    end

  end

#review problems
def factors(num)
  (1..num).select {|el| num % el == 0 }
end


def substrings(string)
  temp_arr = []
    string.each_char.with_index do |_,j|
      (j...string.length).each do |i|
        temp_arr << string[j..i]
      end
    end
  temp_arr.uniq.sort
end

def subwords(word, dictionary)
  temp_arr = substrings(word)
  temp_arr.delete(word)
  temp_arr.select {|combo| dictionary.include?(combo)}
end



return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

p return_value

puts "test2"

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []


puts "test3"

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

puts "test4"

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false

p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

puts "test5"

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
p [[4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]


puts "test6"

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

puts "test7"

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

puts "test8"

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

puts "test9"
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
