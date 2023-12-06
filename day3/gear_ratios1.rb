# frozen_string_literal: true

s = ARGF.readlines(chomp: true).map { |l| ".#{l}." }

n = s.length
s.prepend '.' * (n + 2)
s.append  '.' * (n + 2)

ans = 1.upto(n).sum do |i|
  s[i].gsub(/\d+/).sum do |num|
    a, b = Regexp.last_match.offset(0)
    a -= 1

    regex = /^[.\d]*$/
    exclude = s[i][a] == '.' && s[i][b] == '.'
    exclude &= s[i - 1][a..b].match? regex
    exclude &= s[i + 1][a..b].match? regex
    exclude ? 0 : num.to_i
  end
end

puts ans
