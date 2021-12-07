# frozen_string_literal: true

module Year2015
  class Day02
    def part_1(input)
      parsed_input(input).map do |box|
        area  = box.permutation(2).map { |dim| dim.reduce(:*) }.sum
        extra = box[0..1].reduce(:*)
        area + extra
      end.sum
    end

    def part_2(input)
      parsed_input(input).map do |box|
        perimeter = box[0..1].sum * 2
        volume    = box.reduce(:*)
        perimeter + volume
      end.sum
    end

    private

    def parsed_input(input)
      input.lines.map { |line| line.split('x').map!(&:to_i).sort }
    end
  end
end
