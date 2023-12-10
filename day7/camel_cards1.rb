# frozen_string_literal: true

cards = ARGF.readlines(chomp: true).map { |line| line.split(' ') }

replacements = {
  'T' => 'a',
  'J' => 'b',
  'Q' => 'c',
  'K' => 'd',
  'A' => 'e'
}

regex = Regexp.union(replacements.keys)

cards.each do |card|
  s = card[0].gsub(regex, replacements)
  card[0] = s.each_char.tally.values.sort.reverse.join + s
end

cards.sort_by!(&:first)

ans = cards.map(&:last).each.with_index(1).sum { |card, index| card.to_i * index }

puts ans
