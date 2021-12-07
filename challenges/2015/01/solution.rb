# frozen_string_literal: true

module Year2015
  class Day01
    def part_1(input)
      input.chars.each.with_object([]) do |char, result|
        result << case char
                  when '('
                    1
                  when ')'
                    -1
                  end
      end.sum
    end

    def part_2(input)
      input.chars.each.with_index.inject(0) do |floor, (char, idx)|
        case char
        when '('
          floor += 1
        when ')'
          floor -= 1
        end
        break idx + 1 if floor == -1

        floor
      end
    end
  end
end
