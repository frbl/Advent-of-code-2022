#!/usr/bin/env ruby
puts '=' * 10
# input = 'test.txt'
input = 'input.txt'

def is_valid?(dat); end

# Build up array
dat = []
File.foreach(input) do |line|
  dat << line.split('').select { |x| x != "\n" }.map(&:to_i)
end

boolean_grid = dat.map.with_index do |arr, idx|
  puts
  arr.map.with_index do |tree, jdx|
    # on edge
    next false if idx.zero? || idx == dat.length - 1
    next false if jdx.zero? || jdx == arr.length - 1

    left = false
    right = false
    top = false
    bottom = false

    horizon = arr.map.with_index do |other_tree, inner_jdx|
      res = tree <= other_tree
      if inner_jdx < jdx
        left ||= res
      elsif inner_jdx > jdx
        right ||= res
      end
    end

    vertical = dat.map.with_index do |other_tree, inner_idx|
      res = tree <= other_tree[jdx]
      if inner_idx < idx
        top ||= res
      elsif inner_idx > idx
        bottom ||= res
      end
    end


    # left = arr[jdx - 1]
    # right = arr[jdx + 1]

    # top = dat[idx - 1][jdx]
    # bottom = dat[idx + 1][jdx]

    # puts "#{tree} #{left} #{right} #{top} #{bottom}"

    # res = tree <= left &&
    # tree <= right &&
    # tree <= top &&
    # tree <= bottom

    left && right && top && bottom
  end
end

puts boolean_grid.map { |x| x.map { |y| y ? 'x' : '0' }.join }

puts boolean_grid.flatten.sum { |x| x ? 0 : 1 }
(0...2).each
