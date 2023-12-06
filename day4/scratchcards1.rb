# frozen_string_literal: true

ans = ARGF.readlines.sum do |line|
  winning_numbers, nums = line.split('|')
  winning_numbers = winning_numbers.split(':')[1].split.map(&:to_i)
  nums = nums.split.map(&:to_i)
  count = (nums & winning_numbers).size
  count == 0 ? 0 : 2 ** (count - 1)
end

puts ans
