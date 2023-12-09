# frozen_string_literal: true

arr = ARGF.readline.split(':').last.split.map(&:to_i)

ARGF.readline

7.times do
  ARGF.readline
  r = []
  until ARGF.eof?
    a, b, n = ARGF.readline.split.map(&:to_i)
    # puts a, b, n
    break if n.nil?

    x = a...a + n
    y = b...b + n
    r << [y, x]
  end

  arr.map! do |v|
    p, q = r.find { |r1, _| r1.cover? v }
    v = q.begin + (v - p.begin) unless p.nil?
    v
  end
end

puts arr.min
