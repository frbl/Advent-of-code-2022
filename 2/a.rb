#!/usr/bin/env ruby

# A / X = rock 1 point
# B / Y = paper 2 points
# C / Z = scissors 3 points
# 0 points for loss
# 3 points for draw
# 6 points for win
MAP = {
  'A' => 'r',
  'X' => 'r',
  'B' => 'p',
  'Y' => 'p',
  'C' => 's',
  'Z' => 's',
}
def score(he, me)
  return 3 if MAP[he] == MAP[me]

  win = (he == 'A' && me == 'Y') ||
        (he == 'B' && me == 'Z') ||
        (he == 'C' && me == 'X')
  return win ? 6 : 0
end

def extra_points(me)
  return 1 if me == 'X'
  return 2 if me == 'Y'
  3 
  
end

sum = 0
File.foreach('input.txt') do |line|
  he, me = line.split(' ')
  sum += score(he, me) + extra_points(me)
end
puts sum
