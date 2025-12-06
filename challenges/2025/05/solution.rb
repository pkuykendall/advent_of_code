# frozen_string_literal: true

module Year2025
  class Day05 < Solution
    class InventoryManagementSystem
      attr_reader :fresh_ranges, :ingredient_ids

      def initialize
        @fresh_ranges = []
        @ingredient_ids = []
      end

      def fresh_ingredient_count
        ingredient_ids.count { |id| fresh_ranges.any? { |range| range.cover?(id) } }
      end

      def merged_ranges
        sorted = fresh_ranges.sort_by(&:begin)
        sorted.drop(1).each_with_object([sorted.first]) do |range, acc|
          last = acc.last
          if last.overlap?(range)
            acc[-1] = merge_ranges(last, range)
          else
            acc << range
          end
        end
      end

      def add_fresh_range(range)
        @fresh_ranges << range
      end

      def add_ingredient(id)
        @ingredient_ids << id
      end

      private

      def merge_ranges(one, two)
        [one.begin, two.begin].min..[one.end, two.end].max
      end
    end

    def part_1
      data.fresh_ingredient_count
    end

    def part_2
      data.merged_ranges.sum(&:size)
    end

    private

    def process_dataset(set)
      ims = InventoryManagementSystem.new
      set.each do |line|
        if line.include?('-')
          start_id, end_id = line.split('-').map(&:to_i)
          ims.add_fresh_range(start_id..end_id)
        elsif !line.strip.empty?
          ims.add_ingredient(line.to_i)
        end
      end
      ims
    end
  end
end
