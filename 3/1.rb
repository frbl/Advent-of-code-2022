#!/usr/bin/env ruby
puts 'hoi'
input = 'input.txt'

puts '---------------------'
def priority(input)
  offset = 96
  is_upper = /[[:upper:]]/.match(input)
  val = input.downcase.bytes.first - offset
  is_upper ? val + 26 : val
end


total = 0
File.foreach(input) do |line|
  length = line.length
  comp_one = line[0...length/2]
  comp_two = line[length/2...length]
  in_both = comp_one.split('').uniq & comp_two.split('').uniq
  total += in_both.reduce(0) {|tot, cur| tot += priority(cur)}
end

puts total
