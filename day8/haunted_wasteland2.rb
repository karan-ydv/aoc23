# frozen_string_literal: true

path = ARGF.readline.strip

ARGF.readline

map = ARGF.readlines.map do |line|
  kv = line.scan(/(\w+) = \((\w+), (\w+)\)/).flatten
  [kv.shift, kv]
end.to_h

keys = map.keys.select { |k| k.end_with?('Z') }
n = path.size

keys.map! do |x|
  ans = 0
  loop do
    x = map[x][path[ans % n] == 'L' ? 0 : 1]
    ans += 1
    break if x.end_with?('Z')
  end
  ans
end

p keys.reduce(1, :lcm)
