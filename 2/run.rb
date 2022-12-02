#!/usr/bin/env ruby

# A = rock 1 point
# B = paper 2 points
# C = scissors 3 points
# X = need to lose
# Y = need to draw
# Z = need to win
# 0 points for loss
# 3 points for draw
# 6 points for win

def score(he, me)
  return 3 if he == me

  win = (he == 'A' && me == 'B') ||
        (he == 'B' && me == 'C') ||
        (he == 'C' && me == 'A')
  return win ? 6 : 0
end

def extra_points(me)
  return 1 if me == 'A'
  return 2 if me == 'B'
  3 
end

PLAYS = {
  'A' => {'Z' => 'B', 'X' => 'C'},
  'B' => {'Z' => 'C', 'X' => 'A'},
  'C' => {'Z' => 'A', 'X' => 'B'},
}
def my_play(he, win_or_lose)
  return he if win_or_lose == 'Y'

  return PLAYS[he][win_or_lose]
end

sum = 0
File.foreach('input.txt') do |line|
  he, win_or_lose = line.split(' ')
  me = my_play(he, win_or_lose) 
  sum += score(he, me) + extra_points(me)
end
puts sum
