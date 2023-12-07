# frozen_string_literal: true

module Grid
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
end
