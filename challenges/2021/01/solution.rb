# frozen_string_literal: true

require_relative '../../modules/conversion.rb'
module Year2021
  class Day01
    include Conversion

    def part_1(input)
      numbers = convert_to_int_array(input)
      count_of_increasing(numbers)
    end

    def part_2(input)
      numbers = convert_to_int_array(input)
      sums = numbers.each_cons(3).map(&:sum)
      count_of_increasing(sums)
    end

    private

    def count_of_increasing(numbers)
      numbers.each_cons(2).select { |first, second| second > first }.count
    end

  end
end
