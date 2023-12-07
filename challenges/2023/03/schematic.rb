# frozen_string_literal: true

class Schematic < Grid::BaseGrid
  attr_accessor :symbol_index

  def part_number_sum
    symbol_index.sum do |symbol|
      neighbors_for_point(symbol, include_diagonal: true).sum(&:count_once)
    end
  end

  def gear_ratio_sum
    symbol_index.sum do |symbol|
      neighbors = neighbors_for_point(symbol, include_diagonal: true).select(&:numeric?).uniq
      next 0 unless neighbors.count == 2

      neighbors.reduce(1) { |product, neighbor| product * neighbor.numeric_value }
    end
  end

  private

  LAZY_HASH = ->(h, k) { h[k] = Hash.new(&LAZY_HASH) }.freeze

  def before_initialize
    super
    @symbol_index = []
  end

  def initialize_grid
    each.with_index do |line, y_idx|
      current_number = nil
      line.each.with_index do |value, x_idx|
        point = self.class.point_class.new(x_idx, y_idx, value)

        case value
        when /\d/
          current_number ||= self.class.point_class.new(x_idx, y_idx, [])
          current_number.value << value
          point = current_number
        when '.'
          current_number = nil
        else
          symbol_index << point
          current_number = nil
        end

        self[y_idx][x_idx] = point
      end
    end
  end

  def transform_value(value)
    value
  end

  class SchematicPoint < Grid::Point
    attr_accessor :counted

    # @return [Integer]
    # @param [Boolean] force
    def count_once(force = false)
      return 0 if counted && !force

      @counted = true

      return 0 unless numeric?

      numeric_value
    end

    def numeric_value
      Integer(value.join)
    end

    def numeric?
      value.is_a? Array
    end
  end

  self.point_class = SchematicPoint
end
