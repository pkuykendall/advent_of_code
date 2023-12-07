# frozen_string_literal: true

module Year2023
  class Day03 < Solution
    def part_1
      schematic = Schematic.new(data)

      schematic.part_number_sum
    end

    def part_2
      schematic = Schematic.new(data)

      schematic.gear_ratio_sum
    end

    private

    # @param [String] line
    def process_input(line)
      line.strip.chars
    end
  end
end
