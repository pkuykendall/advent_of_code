# frozen_string_literal: true

module Year2025
  class Day04 < Solution
    class Warehouse < Grid::BaseGrid
      class Space < Grid::Point
        attr_reader :occupied
        alias occupied? occupied

        PAPER_ROLL = '@'

        def occupied?
          PAPER_ROLL === value
        end

        def remove!
          @value = '.'

          true
        end
      end

      self.point_class = Space

      def transform_value(value)
        value
      end

      def count_movable
        count = 0
        iterate_points do |space|
          next unless space_movable? space

          count += 1
        end.sum
        count
      end

      def count_removable
        count = 0
        iterate_points do |space|
          next unless space_movable? space

          space.remove!
          count += 1
        end.sum
        count
      end

      def space_movable?(space)
        return false unless space.occupied?

        neighbors_for_point(space, include_diagonal: true).count do |neighboring_space|
          neighboring_space&.occupied?
        end < 4
      end
    end

    def part_1
      warehouse = Warehouse.new(data)
      warehouse.count_movable
    end

    def part_2
      warehouse = Warehouse.new(data)
      total = 0

      loop do
        removed = warehouse.count_removable
        total += removed
        break if removed.zero?
      end

      total
    end

    private

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.strip.chars
    end
  end
end
