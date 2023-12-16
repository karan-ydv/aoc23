# frozen_string_literal: true

class Graph
  attr_accessor :maze, :visited, :edges

  def initialize
    @maze = ARGF.readlines(chomp: true).map { |l| ['#'] + l.chars + ['#'] }

    @maze.append(['#'] * maze[0].length)
    @maze.prepend(['#'] * maze[0].length)

    @edges = {
      '.' => { R: [[0, 1, :R]], L: [[0, -1, :L]], U: [[-1, 0, :U]], D: [[1, 0, :D]] },
      '|' => { U: [[-1, 0, :U]], D: [[1, 0, :D]], R: [[1, 0, :D], [-1, 0, :U]], L: [[1, 0, :D], [-1, 0, :U]] },
      '-' => { L: [[0, -1, :L]], R: [[0, 1, :R]], U: [[0, 1, :R], [0, -1, :L]], D: [[0, 1, :R], [0, -1, :L]] },
      '/' => { U: [[0, 1, :R]], R: [[-1, 0, :U]], D: [[0, -1, :L]], L: [[1, 0, :D]] },
      '\\' => { U: [[0, -1, :L]], L: [[-1, 0, :U]], D: [[0, 1, :R]], R: [[1, 0, :D]] },
    }

    @visited = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = {} } }
  end

  def dfs
    stack = [[1, 1, :R]]

    while stack.any?
      x, y, d = stack.pop

      visited[x][y][d] = true
      # p [x, y, d]

      e = edges[maze[x][y]][d]

      e.each do |dx, dy, nd|
        nx = x + dx
        ny = y + dy

        cell = maze[nx][ny]

        next if cell == '#'
        next if visited[nx][ny][nd]

        stack.append [nx, ny, nd]
      end
    end
  end
end

g = Graph.new
g.dfs

# 1.upto(10) do |i|
#   1.upto(10) do |j|
#     v = g.visited[i][j]
#     print v.length > 0 ? '#' : '.'
#   end
#   puts
# end

puts g.visited.values.sum { |h| h.values.count { |v| v.length > 0 } }
