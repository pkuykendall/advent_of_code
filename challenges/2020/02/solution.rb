# frozen_string_literal: true
module Year2020
  class Day02
    def part_1(input)
      data = parsed_input(input)
      data.count do |entry|
        entry[:password].match?(convert_policy_to_regex(entry[:policy]))
      end
    end

    def part_2(input)
      data = parsed_input(input)
      data.count do |entry|
        indexes, value = entry[:policy].split
        index_1, index_2 = indexes.split('-').map(&:to_i).map { |idx| idx - 1 }
        password = entry[:password]
        (password[index_1] == value) ^ (password[index_2] == value)
      end
    end

    private

    def parsed_input(input)
      lines = input.split("\n")
      lines.map do |line|
        line_parts = line.split(':')
        {
          policy: line_parts.first,
          password: line_parts.last.strip
        }
      end
    end

    def convert_policy_to_regex(policy)
      count, value = policy.split
      Regexp.new(/^(?:[^#{value}]*#{value}[^#{value}]*){#{count.gsub('-', ',')}}$/)
    end
  end
end
