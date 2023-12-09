# frozen_string_literal: true

arr = ARGF.readline.split(':').last.split.map(&:to_i)
arr = arr.each_slice(2).map { |a, b| a...a + b }

ARGF.readline

7.times do
  ARGF.readline
  s = []
  until ARGF.eof?
    a, b, n = ARGF.readline.split.map(&:to_i)
    # puts a, b, n
    break if n.nil?

    x = a...a + n
    y = b...b + n
    s << [y, x]
  end

  s.sort_by! { |k, _| k.begin }

  arr = arr.flat_map do |v|
    z = []
    s.each do |p, q|
      next unless p.cover?(v.begin) || v.cover?(p.begin)

      z << (v.begin...p.begin) if v.begin < p.begin
      l = [v.begin, p.begin].max
      r = [v.end, p.end].min
      z << ((q.begin + l - p.begin)...(q.begin + r - p.begin)) if l < r

      v = p.end...v.end

      break unless p.end < v.end
    end
    z << v if v.begin < v.end
    z
  end
end

puts arr.map(&:begin).min
