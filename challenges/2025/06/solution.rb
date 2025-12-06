# frozen_string_literal: true

module Year2025
  class Day06 < Solution
    def part_1
      data.sum do |problem|
        problem[..-2].map(&:to_i).reduce(problem[-1].strip.to_sym)
      end
    end

    def part_2
      data.sum do |problem|
        length   = problem[1].length
        remapped = length.times.map do |idx|
          mapped = problem[..-2].map do |entry|
            entry[idx]
          end
          mapped.join.to_i
        end
        remapped.reduce(problem[-1].strip.to_sym)
      end
    end

    private

    # Processes the dataset as a whole
    def process_dataset(input)
      max_line_length = 0

      column_splits = input.map do |line|
        max_line_length = [max_line_length, line.length].max
        line.enum_for(:scan, ' ').map { Regexp.last_match.begin(0) }
      end.reduce(:&)

      parse_input(max_line_length, input, column_splits)
    end

    def parse_input(longest_line, set, column_splits)
      set.each.with_object([]) do |line, problems|
        split_at_indices(line.ljust(longest_line), column_splits)
          .each_with_index do |factor, col_idx|
          (problems[col_idx] ||= []) << factor
        end
      end
    end

    def split_at_indices(string, indices = [])
      arr = string.chars
      indices.each { |idx| arr[idx] = '|' }
      arr.join.split('|')
    end
  end
end
