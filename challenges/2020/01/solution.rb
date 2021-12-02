# frozen_string_literal: true

require_relative '../../modules/conversion'

module Year2020
  class Day01
    include Conversion
    def part_1(input)
      product_of_items_matching_sum(input, item_count: 2)
    end

    def part_2(input)
      product_of_items_matching_sum(input, item_count: 3)
    end

    private

    def product_of_items_matching_sum(input, item_count:, sum: 2020)
      numbers = convert_to_int_array(input)
      matched = numbers.combination(item_count).find { |items| items.sum == sum }
      matched.reduce(:*)
    end
  end
end
