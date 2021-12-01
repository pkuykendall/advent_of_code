# frozen_string_literal: true
module Year2021
  class Day01
    def part_1(input)
      numbers = convert_input(input)
      count_of_increasing(numbers)
    end

    def part_2(input)
      numbers = convert_input(input)
      sums = numbers.each_cons(3).map(&:sum)
      count_of_increasing(sums)
    end

    private

    def count_of_increasing(numbers)
      numbers.each_cons(2).select { |first, second| second > first }.count
    end

    def convert_input(input)
      input.split.map(&:to_i)
    end
  end
end
