# frozen_string_literal: true

module Year2020
  class Day03
    def part_1(input)
      count_trees_in_path(input, down: 1, right: 3)
    end

    def part_2(input)
      [
        { down: 1, right: 1 },
        { down: 1, right: 3 },
        { down: 1, right: 5 },
        { down: 1, right: 7 },
        { down: 2, right: 1 }
      ].map do |scenario|
        count_trees_in_path(input, down: scenario[:down], right: scenario[:right])
      end.reduce(:*)
    end

    private

    def count_trees_in_path(input, down:, right:)
      lines = input.lines.select.with_index { |_, idx| (idx % down).zero? }.map(&:strip)
      lines.map.with_index.inject(0) do |count, (line, idx)|
        position = (idx * right) % line.length
        if line[position] == '#'
          count + 1
        else
          count
        end
      end
    end
  end
end
