#!/usr/bin/env ruby
# input = 'test.txt'
input = 'input.txt'

tot = 0

def a_in_b(a, b)
  a[0] >= b[0] && a[0] <= b[1] ||
    a[1] >= b[1] && a[1] <= b[0]
end

def check(input)
  first, second = input.split(',')

  first = first.split('-').map { |x| x.to_i }
  second = second.split('-').map { |x| x.to_i }

  res = a_in_b(first, second) || a_in_b(second, first)

  res ? 1 : 0
end

File.foreach(input) do |line|
  tot += check(line)
end
puts '---'
puts tot
