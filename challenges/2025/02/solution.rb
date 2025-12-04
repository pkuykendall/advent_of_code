# frozen_string_literal: true
module Year2025
  class Day02 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    REGEX = /^(\d+?)\1$/
    REPEATED_REGEX = /^(\d+?)\1+$/
    def part_1
      data.each_slice(2).sum do |min, max|
        (min..max).sum do |num|
          next 0 unless REGEX.match? num

          num.to_i
        end
      end
    end

    def part_2
      data.each_slice(2).sum do |min, max|
        (min..max).sum do |num|
          next 0 unless REPEATED_REGEX.match? num

          num.to_i
        end
      end
    end

    private
    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.split(/[,-]/)
    end
  end
end
