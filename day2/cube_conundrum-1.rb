ans = ARGF.each_line.sum do |line|
  game, sets = line.split(':')
  id = game.split(' ').last
  invalid = sets.split(';').any? do |set|
    set = set.split(',')

    red = set.find { |x| x.include? 'red' }&.split(' ')&.first&.to_i
    green = set.find { |x| x.include? 'green' }&.split(' ')&.first&.to_i
    blue = set.find { |x| x.include? 'blue' }&.split(' ')&.first&.to_i

    (red&. > 12) || (green&. > 13) || (blue&. > 14)
  end

  invalid ? 0 : id.to_i
end

puts ans
