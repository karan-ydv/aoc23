# frozen_string_literal: true

require 'matrix'

class Graph
  attr_accessor :edges, :maze, :path_lengths, :startx, :starty

  def initialize
    @edges = {
      '-' => [[0, 1], [0, -1]],
      '|' => [[1, 0], [-1, 0]],
      'L' => [[-1, 0], [0, 1]],
      'J' => [[-1, 0], [0, -1]],
      '7' => [[1, 0], [0, -1]],
      'F' => [[1, 0], [0, 1]],
      'S' => [[1, 0], [0, 1], [-1, 0], [0, -1]],
      '.' => []
    }

    @maze = ARGF.readlines(chomp: true).map { |l| ['.'] + l.chars + ['.'] }

    @maze.append(['.'] * maze[0].length)
    @maze.prepend(['.'] * maze[0].length)

    @startx, @starty = Matrix[*maze].index('S')
    @path_lengths = []
    @h = Hash.new { |h, k| h[k] = {} }
  end

  def dfs(x = startx, y = starty)
    distance = Array.new(maze.length) { Array.new(maze[0].length, 0) }
    stack = [[x, y, 0, 0, 0]]

    while stack.any?
      x, y, px, py, d = stack.pop

      if maze[x][y] == 'E'
        @path_lengths.append(d)
        next
      end

      e = edges[maze[x][y]]

      @maze[x][y] = '.' if maze[x][y] != 'S'
      @maze[x][y] = 'E' if maze[x][y] == 'S'

      e.each do |dx, dy|
        nx = x + dx
        ny = y + dy

        next if maze[nx][ny] == '.'
        next if nx == px && ny == py

        stack.append([nx, ny, x, y, d + 1])
      end

    end
  end
end

g = Graph.new
g.dfs
p g.path_lengths
puts (g.path_lengths.max + 1) / 2 
