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
  end

  def visited_count
    visited.values.sum { |h| h.values.count { |v| v.length > 0 } }
  end

  def dfs(stack)
    @visited = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = {} } }

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

    visited_count
  end
end


g = Graph.new
n = g.maze.length - 2

c = 1.upto(n).map do |i|
  [
    g.dfs([[i, 1, :R]]),
    g.dfs([[i, n, :L]]),
    g.dfs([[1, i, :D]]),
    g.dfs([[n, i, :U]]),
  ].max
end

puts c.max
