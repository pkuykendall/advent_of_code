# frozen_string_literal: true

require_relative '../modules/color_output'
require 'matrix'

class Grid < Array
  include ColorOutput

  class << self
    attr_accessor :point_class, :bfs_eligibility_proc, :bfs_action_proc
  end

  class Point
    attr_accessor :x_idx, :y_idx, :value, :color

    def initialize(x_idx, y_idx, value = '.', color = :green)
      @x_idx = x_idx
      @y_idx = y_idx
      @value = value
      @color = color
    end

    NORTH_DELTA = Vector[0, -1].freeze
    SOUTH_DELTA = Vector[0, 1].freeze
    EAST_DELTA  = Vector[1, 0].freeze
    WEST_DELTA  = Vector[-1, 0].freeze

    def location = @location ||= Vector[x_idx, y_idx]

    def north = @north ||= (location + NORTH_DELTA)

    def south = @south ||= (location + SOUTH_DELTA)

    def east = @east ||= (location + EAST_DELTA)

    def west = @west ||= (location + WEST_DELTA)

    def northeast = @northeast ||= (north + EAST_DELTA)

    def northwest = @northwest ||= (north + WEST_DELTA)

    def southeast = @southeast ||= (south + EAST_DELTA)

    def southwest = @southwest ||= (south + WEST_DELTA)

    def neighbors
      %i[north south east west].map do |direction|
        public_send(direction).to_a
      end
    end

    def all_neighbors
      %i[north south east west northeast northwest southeast southwest].map do |direction|
        public_send(direction).to_a
      end
    end
  end

  self.bfs_eligibility_proc = lambda { |point|
    return false if point.nil?

    true
  }

  def self.inherited(subclass)
    super
    subclass.point_class          = Point
    subclass.bfs_eligibility_proc = bfs_eligibility_proc
  end

  def initialize(*several_variants)
    super
    each.with_index do |line, y_idx|
      line.each.with_index do |_value, x_idx|
        self[y_idx][x_idx] = self.class.point_class.new(x_idx, y_idx, self[y_idx][x_idx].to_i, GREEN)
      end
    end
  end

  def each_element(&block)
    each { |line| line.each(&block) }
  end

  def map_elements(&block)
    map { |line| line.map(&block) }
  end

  private

  def bfs(point)
    queue   = [point]
    visited = { point => [] }
    loop do
      current = queue.pop
      yield(current, visited, queue, point)
      break visited if queue.empty?
    end
  end

  def eligible_neighbors(point, include_diagonal)
    neighbors_for_point(point, include_diagonal: include_diagonal).select do |neighbor|
      next false if neighbor.nil?
      next false if self.class.bfs_eligibility_proc.nil?

      self.class.bfs_eligibility_proc.call(neighbor)
    end
  end

  def neighbors_for_point(point, include_diagonal: false)
    neighbors = if include_diagonal
                  point.all_neighbors
                else
                  point.neighbors
                end
    neighbors.map { |neighbor_coords| point_at(*neighbor_coords) }
  end

  def point_at(x_idx, y_idx)
    return nil if x_idx.negative? || y_idx.negative?
    return nil if y_idx >= length
    return nil if x_idx >= self[y_idx].length

    self[y_idx][x_idx]
  end
end
