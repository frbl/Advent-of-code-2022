#!/usr/bin/env ruby

result = []
sum = 0
File.open('day1-input.txt') do |file_handle|
  file_handle.each do |line|
    if line != "\n"
      sum += line.to_i
    else
      result << sum
      sum = 0
    end
  end

end
# 1
puts result.max

# 2
puts result.max(3).sum
