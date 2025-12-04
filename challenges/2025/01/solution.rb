# frozen_string_literal: true

module Year2025
  class Day01 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    DIRECTION_MAP = {
      'L' => -1,
      'R' => 1
    }.freeze

    class Dial
      attr_reader :dial_size, :position

      private attr_reader :dial

      def initialize(dial_size, starting_position)
        @dial_size = dial_size
        @position = starting_position
        @dial = (0...dial_size).to_a.freeze
      end

      def turn(direction, distance)
        new_position = position + (direction * distance)
        @position = dial[new_position % dial_size]
      end

      def turn_and_count_clicks(direction, distance)
        clicks = 0

        quotient = (((direction * position) + distance) / dial_size)
        quotient_2 = (direction * position / dial_size)
        clicks += quotient - quotient_2


        turn(direction, distance)

        clicks
      end

      def zero?
        position.zero?
      end

    end

    def part_1
      dial = Dial.new(100, 50)
      counter = 0
      data.each do |direction, distance|
        dial.turn(direction, distance)

        counter += 1 if dial.zero?
      end
      counter
    end

    def part_2
      dial = Dial.new(100, 50)
      counter = 0
      data.each do |direction, distance|
        counter += dial.turn_and_count_clicks(direction, distance)
      end
      counter
    end

    private

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      direction = DIRECTION_MAP[line[0]]
      distance  = Integer(line[1..])

      [direction, distance]
    end

  end
end
