# frozen_string_literal: true

module Year2022
  class Day06 < Solution
    def part_1
      find_message_start(4)
    end

    def part_2
      find_message_start(14)
    end

    private

    def find_message_start(uniq_chars)
      data.chars.each_cons(uniq_chars).with_index do |chars, idx|
        break idx + uniq_chars if chars.uniq.count == uniq_chars
      end
    end
  end
end
