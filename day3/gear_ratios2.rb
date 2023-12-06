# frozen_string_literal: true

s = ARGF.readlines(chomp: true).map { |l| ".#{l}." }

n = s.length
s.prepend '.' * (n + 2)
s.append  '.' * (n + 2)

nums = s.map { |line| line.gsub(/.(\d+)/).map { [Regexp.last_match(1).to_i, Range.new(*Regexp.last_match.offset(0))] } }

ans = 1.upto(n).sum do |i|
  s[i].gsub(/\*/).sum do
    gear_index = Regexp.last_match.begin(0)
    adjacent_parts = nums[(i - 1)..(i + 1)].flat_map { |p| p.select { |_, r| r.cover?(gear_index) } }.map(&:first)
    adjacent_parts.length == 2 ? adjacent_parts.inject(&:*) : 0
  end
end

puts ans
