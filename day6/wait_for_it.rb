# frozen_string_literal: true

# remove spaces manually for part 2

times = ARGF.readline.split(':').last.split.map(&:to_i)
distances = ARGF.readline.split(':').last.split.map(&:to_i)

chances = times.zip(distances).map do |time, distance|
  1.upto(time).count { |k| (time - k) * k > distance }
end

puts chances.inject(:*)
