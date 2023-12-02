h = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9
}

h.merge! (1..9).map { |i| [i.to_s, i] }.to_h

# regex = /(\d)/ # part 1
regex = /(one|two|three|four|five|six|seven|eight|nine|\d)/

ans = ARGF.each_line.sum do |line|
  line.match regex
  first = $1
  i = line.rindex regex
  line.match regex, i
  last = $1
  h[first] * 10 + h[last]
end

puts ans
