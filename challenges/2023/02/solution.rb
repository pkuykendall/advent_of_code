# frozen_string_literal: true

module Year2023
  class Day02 < Solution
    class << self
      attr_accessor :game_class
    end

    NUM_RED_CUBES   = 12
    NUM_GREEN_CUBES = 13
    NUM_BLUE_CUBES  = 14

    def part_1
      data.sum do |game|
        next 0 unless game.valid?

        game.game_number
      end
    end

    def part_2
      data.sum(&:power)
    end

    private

    self.game_class = Struct.new(:game_number, :max_red, :max_green, :max_blue) do
      def valid?
        return false if max_red > NUM_RED_CUBES
        return false if max_green > NUM_GREEN_CUBES
        return false if max_blue > NUM_BLUE_CUBES

        true
      end

      def power
        max_red * max_green * max_blue
      end
    end

    def process_input(line)
      game_str, draws_str = line.split(':')
      game_number         = game_str[5..].to_i

      color_maxes = new_color_hash

      draws_str.split(';').each do |draw|
        calculate_maxes(color_maxes, draw)
      end

      self.class.game_class.new(game_number, *color_maxes.values)
    end

    def new_color_hash
      {
        red: 0,
        green: 0,
        blue: 0
      }
    end

    def calculate_maxes(color_maxes, draw)
      draw.split(',').map(&:split).each do |(count, color)|
        color_maxes[color.to_sym] = [color_maxes[color.to_sym], count.to_i].max
      end
    end
  end
end
