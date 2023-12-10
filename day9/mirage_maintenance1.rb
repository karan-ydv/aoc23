# frozen_string_literal: true

def next_seq(seq)
  return seq.first if seq.all?(seq.first)

  next_seq(seq.each_cons(2).map { |a, b| b - a }) + seq.last
end

ans = ARGF.readlines.sum do |line|
  next_seq line.split.map(&:to_i).reverse
end

puts ans
