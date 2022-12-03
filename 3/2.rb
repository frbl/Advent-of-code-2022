#!/usr/bin/env ruby
input = 'input.txt'
# ls *.rb | entr -r ./run.rb

def priority(input)
  offset = 96
  is_upper = /[[:upper:]]/.match(input)
  val = input.downcase.bytes.first - offset
  is_upper ? val + 26 : val
end

tmp = []
total = 0
File.foreach(input) do |line|
  tmp << line
  next if tmp.length != 3

  in_all_three = tmp[0].split('').uniq &
                 tmp[1].split('').uniq &
                 tmp[2].split('').uniq

  # Remove the newlines that are added for each
  in_all_three -= ["\n"]

  # Reduce, in case there are multiple matches
  total += in_all_three.reduce(0) { |tot, cur| tot + priority(cur) }
  tmp = []
end

puts total
