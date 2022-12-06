# frozen_string_literal: true

module Year2022
  class Day01 < Solution
    class Elf
      def initialize
        @food_items     = []
        @total_calories = 0
      end

      def add_food(calories)
        @total_calories += calories
        @food_items << calories
      end

      attr_reader :total_calories
    end

    def part_1
      max_elf_calories = 0
      current_elf      = Elf.new

      data.each do |line|
        next current_elf.add_food(line) if line.is_a? Integer

        max_elf_calories = find_max_calories(current_elf, max_elf_calories)
        current_elf      = Elf.new
      end

      find_max_calories(current_elf, max_elf_calories)
    end

    def part_2
      top_elf_calories = []
      current_elf      = Elf.new

      data.each do |line|
        next current_elf.add_food(line) if line.is_a? Integer

        top_elf_calories = find_top_3_calories(current_elf, top_elf_calories)
        current_elf      = Elf.new
      end

      find_top_3_calories(current_elf, top_elf_calories).sum
    end

    private

    def find_top_3_calories(current_elf, top_elf_calories)
      top_elf_calories << current_elf.total_calories
      top_elf_calories.max(3)
    end

    def find_max_calories(current_elf, max_elf_calories)
      [current_elf.total_calories, max_elf_calories].max
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      return '' if line.empty?

      line.to_i
    end
  end
end
