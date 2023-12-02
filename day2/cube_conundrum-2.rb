ans = ARGF.each_line.sum do |line|
  _, sets = line.split(':')

  red = sets.scan(/(\d+) red/).flatten.map(&:to_i).max
  green = sets.scan(/(\d+) green/).flatten.map(&:to_i).max
  blue = sets.scan(/(\d+) blue/).flatten.map(&:to_i).max

  red * green * blue
end

puts ans
