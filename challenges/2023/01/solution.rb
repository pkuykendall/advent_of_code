# frozen_string_literal: true

module Year2023
  class Day01 < Solution
    NUMBER_MAP = {
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9
    }.freeze

    NUMBER_REGEX = /\d/
    WORD_REGEX   = /(?=(\d|one|two|three|four|five|six|seven|eight|nine))/

    def part_1
      data.sum do |line|
        matches = line.scan(NUMBER_REGEX).values_at(0, -1)
        Integer(matches.join)
      end
    end

    def part_2
      data.sum do |line|
        matches = line.scan(WORD_REGEX).flatten.values_at(0, -1)

        converted_matches = matches.map do |match|
          (NUMBER_MAP[match.to_sym] || match).to_s
        end

        Integer(converted_matches.join)
      end
    end
  end
end
