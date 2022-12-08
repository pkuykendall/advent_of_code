# frozen_string_literal: true

module Year2022
  class Day05 < Solution
    class << self
      attr_accessor :move_class
    end

    self.move_class = Struct.new(:number, :from, :to)

    def initialize(input)
      super(input)
      @stacks = Array.new(9) { [] }
      @moves  = []
    end

    def part_1
      data
      moves.each do |move|
        move.number.times do
          stacks[move.to - 1] << stacks[move.from - 1].pop
        end
      end
      stacks.map(&:last).join
    end

    def part_2
      data
      moves.each do |move|
        stacks[move.to - 1] += stacks[move.from - 1].pop(move.number)
      end
      stacks.map(&:last).join
    end

    private

    attr_accessor :stacks, :moves

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      if line.include?('[')
        parse_stack_input(line)
      elsif line.start_with?('move')
        moves << self.class.move_class.new(*line.scan(/\d+/).map(&:to_i))
      end
    end

    def parse_stack_input(line)
      line.chars.each_slice(4).with_index.map do |ary, idx|
        next unless ary[0] == '['

        stacks[idx].prepend ary[1]
      end
    end
  end
end
