# frozen_string_literal: true

module Year2022
  class Day03 < Solution
    def part_1
      data.sum do |line|
        rucksack_priority(*split_line(line))
      end
    end

    def part_2
      data.each_slice(3).sum do |lines|
        rucksack_priority(*lines.flatten)
      end
    end

    private

    def rucksack_priority(*compartments)
      priorities[find_common_letter(*compartments)]
    end

    def priorities
      @priorities ||= begin
        hsh = ('a'..'z').zip(1..26).to_h
        hsh.merge!(('A'..'Z').zip(27..52).to_h)
      end
    end

    def find_common_letter(*groups)
      groups.map(&:chars).reduce(&:&).first
    end

    def split_line(line)
      line.chars.each_slice(line.length / 2).map(&:join)
    end
  end
end
