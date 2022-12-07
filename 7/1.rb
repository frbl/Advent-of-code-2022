#!/usr/bin/env ruby
puts '=' * 10
#input = 'test.txt'
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

def build_structure(input)
  struct = {}
  cur = []
  File.foreach(input) do |line|
    if command?(line)
      cmd, param = parse_command(line)
      if cmd == 'cd'
        param == '..' ? cur.pop : cur.push(param)
        struct[cur.join] ||= { files: [], size: 0, tot_size: 0 }
      end
    else # output
      size, file = files(line)
      next if size.nil?

      struct[cur.join][:files] << file
      struct[cur.join][:size] += size
    end
  end
  struct
end

@struct = build_structure(input)

@struct.each_key do |folder|
  sub_folders = @struct.keys.select { |x| x.start_with? folder }
  @struct[folder][:tot_size] = sub_folders.reduce(0) { |sum, entry| sum + @struct[entry][:size] }
end

big_dir = @struct.select { |k, x| x[:tot_size] <= 100_000 && k != '/' }

puts(big_dir.sum { |_k, x| x[:tot_size] })
