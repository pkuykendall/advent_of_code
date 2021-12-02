# frozen_string_literal: true

module Year2021
  class Day02
    MODIFIERS = begin
      modifiers = Hash.new(1)
      modifiers['up'] = -1
      modifiers
    end.freeze

    def part_1(input)
      directions = input.lines.map.with_object(Hash.new(0)) do |line, loc|
        direction, amount = parse_line(line)
        loc[direction] += amount
      end
      forward = direction_total('forward', directions)
      up = direction_total('up', directions)
      down = direction_total('down', directions)

      forward * (up + down)
    end

    def part_2(input)
      directions = input.lines.map.with_object(Hash.new(0)) do |line, state|
        direction, amount = parse_line(line)
        case direction
        when 'forward'
          move_forward(amount, state)
        else
          change_aim(amount, direction, state)
        end
      end
      directions[:horizontal_pos] * directions[:depth]
    end

    private

    def change_aim(amount, direction, state)
      state[:aim] += (MODIFIERS[direction] * amount)
    end

    def move_forward(amount, state)
      state[:depth] += amount * state[:aim]
      state[:horizontal_pos] += amount
    end

    def parse_line(line)
      direction, amount = line.strip.split
      amount = amount.to_i
      [direction, amount]
    end

    def direction_total(dir_str, directions)
      directions[dir_str] * MODIFIERS[dir_str]
    end
  end
end
