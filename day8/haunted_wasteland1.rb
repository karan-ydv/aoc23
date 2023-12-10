# frozen_string_literal: true

path = ARGF.readline.strip

ARGF.readline

map = ARGF.readlines.map do |line|
  kv = line.scan(/(\w+) = \((\w+), (\w+)\)/).flatten
  [kv.shift, kv]
end.to_h

x = 'AAA'
ans = 0
n = path.size

until x == 'ZZZ'
  x = map[x][path[ans % n] == 'L' ? 0 : 1]
  ans += 1
end

puts ans
