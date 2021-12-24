# frozen_string_literal: true

module Year2021
  class Day14
    def part_1(input)
      polymerize_and_tally(input, iterations: 10)
    end

    def part_2(input)
      polymerize_and_tally(input, iterations: 40)
    end

    private

    def polymerize_and_tally(input, iterations:)
      sequence, substitutions = parse_input(input)
      tallies = sequence.chars.each_cons(2).tally
      tallies.default = 0

      iterations.times do
        tallies = polymerize!(tallies, substitutions)
      end

      totals = calculate_totals(tallies, sequence)

      min_max_difference(totals)
    end

    def min_max_difference(totals)
      min, max = totals.values.minmax
      max - min
    end

    def calculate_totals(tallies, sequence)
      totals = Hash.new(0)
      tallies.each { |(a, _b), tally| totals[a] += tally }
      totals[sequence.chars.last] += 1
      totals
    end

    def parse_input(input)
      starting_sequence, substitution_lines = input.split(/^\n+/)
      starting_sequence.strip!
      substitutions = substitution_lines.lines.map.with_object({}) do |line, hsh|
        key, val = line.strip.split(' -> ')
        hsh[key] = val
      end
      [starting_sequence, substitutions]
    end

    def polymerize!(tallies, substitution_hash)
      next_tally = Hash.new(0)
      tallies.each do |(first, second), tally|
        sub = substitution_hash[first + second]
        next_tally[[first, sub]] += tally
        next_tally[[sub, second]] += tally
      end
      next_tally
    end
  end
end
