#!/usr/bin/env ruby
# input = 'test.txt'
input = 'input.txt'

def run(file, no_unique)
  tmp = []
  File.foreach(file) do |line|
    line.split('').each_with_index do |ch, jdx|
      tmp.push(ch)
      tmp = tmp.drop(1) if tmp.length > no_unique
      next if tmp.length <= (no_unique - 1)

      next unless tmp.uniq.join == tmp.join

      return jdx + 1, tmp.join
    end
  end
end
# 1
puts '===='
puts '1'
puts run(input, 4)

# 1
puts '2'
puts run(input, 14)
