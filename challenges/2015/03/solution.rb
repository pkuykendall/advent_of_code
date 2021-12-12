# frozen_string_literal: true

require 'matrix'
module Year2015
  class Day03
    DIRECTIONS = {
      '^' => Vector[0, -1],
      'v' => Vector[0, 1],
      '>' => Vector[1, 0],
      '<' => Vector[-1, 0]
    }.freeze

    def part_1(input)
      house_map = Hash.new(0)
      current_position = Vector[0, 0]
      house_map[current_position] = 1
      input.strip.each_char do |char|
        current_position += DIRECTIONS[char]
        house_map[current_position] += 1
      end
      house_map.keys.count
    end

    def part_2(input)
      house_map = Hash.new(0)
      santa_position = Vector[0, 0]
      robot_santa_position = Vector[0, 0]
      house_map[santa_position] = 2
      input.strip.each_char.with_index do |char, idx|
        if idx.even?
          santa_position += DIRECTIONS[char]
          house_map[santa_position] += 1
        else
          robot_santa_position += DIRECTIONS[char]
          house_map[robot_santa_position] += 1
        end
      end
      house_map.keys.count
    end
  end
end
