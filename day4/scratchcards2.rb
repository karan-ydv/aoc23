# frozen_string_literal: true

scratchcards = ARGF.readlines

cards = [1] * scratchcards.size

scratchcards.each.with_index.sum do |line, i|
  winning_numbers, nums = line.split('|')
  winning_numbers = winning_numbers.split(':')[1].split.map(&:to_i)
  nums = nums.split.map(&:to_i)
  count = (nums & winning_numbers).size
  1.upto(count).each { |j| cards[i + j] += cards[i] unless cards[j].nil? }
end

puts cards.sum
