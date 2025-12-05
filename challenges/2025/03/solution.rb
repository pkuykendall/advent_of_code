# frozen_string_literal: true

module Year2025
  class Day03 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    REVERSE_RANGE = ('0'..'9').to_a.reverse

    def part_1
      data.sum do |line|
        REVERSE_RANGE.dup.find do |left_num|
          left_idx = line.index(left_num)
          next if left_idx.nil?

          right_num = REVERSE_RANGE.dup.find do |right_num|
            right_idx = line.rindex(right_num)
            next if right_idx.nil?
            next if right_idx <= left_idx

            break right_num
          end
          next if right_num.nil?

          break "#{left_num}#{right_num}"
        end.to_i
      end
    end

    def part_2
      data.sum do |line|
        while line.length > 12
          idx = line.each_cons(2).find_index { |a, b| b > a }
          idx ? line.delete_at(idx) : break
        end

        line[0, 12].join.to_i
      end
    end

    private

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.chars
    end

  end
end
