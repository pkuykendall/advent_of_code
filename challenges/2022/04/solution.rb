# frozen_string_literal: true

module Year2022
  class Day04 < Solution
    def part_1
      data.count do |section_1, section_2|
        section_1.cover?(section_2) || section_2.cover?(section_1)
      end
    end

    def part_2
      data.count do |section_1, section_2|
        smaller, larger = [section_1, section_2].sort_by(&:size)
        smaller.any? do |element|
          larger.member?(element)
        end
      end
    end

    private

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.split(',').map do |section|
        start, finish = section.split('-').map(&:to_i)
        (start..finish)
      end
    end
  end
end
