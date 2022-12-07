#!/usr/bin/env ruby
puts '=' * 10
input = 'test.txt'
input = 'input.txt'

def command?(line)
  line.start_with? '$'
end

def parse_command(line)
  _, cmd, param = line.split(' ')

  [cmd, param]
end

def files(line)
  a, b = line.split(' ')
  return a.to_i, b if a != 'dir'

  [nil, nil]
end

@struct = {}
@cur = []
File.foreach(input) do |line|
  if command?(line)
    cmd, param = parse_command(line)
    if cmd == 'cd'
      if param == '..'
        @cur.pop
      else
        @cur.push(param)
      end
      @struct[@cur.join] ||= { files: [], size: 0, tot_size: -1 }
    end
  else # output

    size, file = files(line)
    unless size.nil?
      @struct[@cur.join][:files] << file
      @struct[@cur.join][:size] += size
    end
  end
end

@struct.keys.each do |folder|
  sub_folders = @struct.keys.select { |x| x.start_with? folder }
  @struct[folder][:tot_size] = sub_folders.reduce(0) { |sum, entry| sum + @struct[entry][:size] }
end

tot_size = 70_000_000 - @struct['/'][:tot_size]
size_needed = 30_000_000 - tot_size
puts size_needed

big_dir = @struct.select { |_k, x| x[:tot_size] >= size_needed }

min = nil
min_folder = nil

big_dir.each do |k,v| 
  min ||= v[:tot_size]
  if v[:tot_size] < min
    min = v[:tot_size]
    min_folder = k
  end
end

puts min
