# frozen_string_literal: true

cards = ARGF.readlines(chomp: true).map { |line| line.split(' ') }

replacements = {
  'T' => 'a',
  'J' => '1',
  'Q' => 'c',
  'K' => 'd',
  'A' => 'e'
}

regex = Regexp.union(replacements.keys)

cards.each do |card|
  t = card[0].each_char.tally
  j = t.delete('J')
  hand = t.values.sort.reverse
  hand << 0 if hand.size.zero?
  hand[0] += j unless j.nil?
  s = card[0].gsub(regex, replacements)
  card[0] = hand.join + s
end

cards.sort_by!(&:first)

ans = cards.map(&:last).each.with_index(1).sum { |card, index| card.to_i * index }

puts ans
