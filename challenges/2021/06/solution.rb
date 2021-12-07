# frozen_string_literal: true
module Year2021
  class Day06
    def part_1(input)
      population_after(80, parse_input(input))
    end

    def part_2(input)
      population_after(256, parse_input(input))
    end

    private

    def parse_input(input)
      input.strip.split(',').map!(&:to_i)
    end

    def population_after(days, initial_fish)
      days.times.with_object(Hash.new(0)) do |num, generations|
        generations.merge!(initial_fish.uniq.map { |i| [i, initial_fish.count(i)] }.to_h) if num == 0
        generations.transform_keys! { |key| key - 1 }
        generations[8] = generations[-1]
        generations[6] += generations[-1]
        generations.delete(-1)
      end.values
      .sum
    end
  end
end
