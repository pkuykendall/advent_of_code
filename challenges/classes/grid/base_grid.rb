# frozen_string_literal: true

require_relative 'concerns/breadth_first_searchable'
require_relative '../../modules/color_output'
require 'matrix'
require_relative 'point'

module Grid
  class BaseGrid < Array
    include ColorOutput

    class << self
      attr_accessor :point_class
    end

    self.point_class = Point

    def self.inherited(subclass)
      super
      subclass.point_class = Point
    end

    def initialize(*several_variants)
      super
      before_initialize
      initialize_grid
      after_initialize
    end

    def each_element(&)
      each { |line| line.each(&) }
    end

    def map_elements(&)
      map { |line| line.map(&) }
    end

    private

    def before_initialize; end

    def after_initialize; end

    def initialize_grid
      each.with_index do |line, y_idx|
        line.each.with_index do |value, x_idx|
          self[y_idx][x_idx] = self.class.point_class.new(x_idx, y_idx, transform_value(value), GREEN)
        end
      end
    end

    def transform_value(value)
      value.to_i
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

    def iterate
      max_x = count
      max_y = first.count
      (0..max_y).each do |y_num|
        (0...max_x).each do |x_num|
          yield(x_num, y_num)
        end
      end
    end

    def iterate_points
      iterate do |x_num, y_num|
        point = point_at(x_num, y_num)
        next unless point

        yield(point)
      end
    end
  end
end
