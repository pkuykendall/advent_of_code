# frozen_string_literal: true

require_relative '../../modules/array_operations'
module Year2021
  class Day07
    include ArrayOperations

    def part_1(input)
      result = calculate_fuel_usage(parse_input(input))
      result.values.min
    end

    def part_2(input)
      result = calculate_fuel_usage(parse_input(input), calculation: :triangular)
      result.values.min
    end

    private

    def parse_input(input)
      input.split(',').map(&:to_i)
    end

    def calculate_fuel_usage(positions, calculation: :linear)
      positions.max.times.with_object({}) do |idx, results|
        results[idx] = positions.map do |position|
          case calculation
          when :linear
            difference(idx, position)
          when :triangular
            triangular(difference(idx, position))
          end
        end.sum
      end
    end

    def difference(idx, position)
      (idx - position).abs
    end

    def triangular(num)
      (num * (num + 1)) / 2
    end
  end
end
