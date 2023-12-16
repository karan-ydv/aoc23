# frozen_string_literal: true

require 'matrix'

inp = ARGF.readlines(chomp: true)

x = inp.map { |e| e.match?(/^\.*$/) ? 1 : 0 }

inp.map! { |line| line.chars }

y = inp.transpose.map(&:join).map { |e| e.match?(/^\.*$/) ? 1 : 0 }

sum = 0; x.map! { |e| sum += e }
sum = 0; y.map! { |e| sum += e }

indices = Matrix[*inp].each_with_index.map { |e, r, c| [r, c] if e == '#' }.compact

ans = indices.product(indices).sum do |(x1, y1), (x2, y2)|
  d = (x1 - x2).abs + (y1 - y2).abs + (x[x2] - x[x1]).abs + (y[y2] - y[y1]).abs
end

ans /= 2

puts ans
