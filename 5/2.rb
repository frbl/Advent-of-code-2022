#!/usr/bin/env ruby
input = 'input.txt'
#input = 'test.txt'
# ls *.rb | entr -r ./run.rb
puts '============='

# Preprocessing
def text_to_state(input)
  state = {}
  input.reverse.each_with_index do |linearr, idx|
    # Skip the bottom line
    next if idx.zero?

    label = 0

    linearr.each_with_index do |char, jdx|
      modded = jdx % 4
      next unless modded == 1

      label += 1
      cur = char.strip
      state[label] ||= []
      state[label].push(cur) unless cur.empty?
    end
  end
  puts state
  state
end

state_array = []

start_idx = 0
File.foreach(input) do |line|
  break if line == "\n"

  start_idx += 1
  state_array << line.split('')
end

@state = text_to_state(state_array)

# Processing

def update_state(command)
  _, number, _, from, _, to = command.split(' ')
  number = number.to_i
  from = from.to_i
  to = to.to_i

  @state[to] += @state[from].pop(number)
end

File.foreach(input).with_index do |line, idx|
  next if idx <= start_idx

  update_state line
  puts @state
end

puts @state.map { |_k, v| v.last }.join
