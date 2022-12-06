# frozen_string_literal: true

module Year2021
  class Day16
    def part_1(input)
      input = input.strip
      bin_str = string_to_binary(input)
      output = parse(bin_str)
      p output
      nil
    end

    def part_2(_input)
      nil
    end

    private

    def string_to_binary(str)
      Array(str).pack('H*').unpack1('B*')
    end

    def parse(bin_str)
      version = bin_str[0..2].to_i(2)
      type = bin_str[3..5].to_i(2)
      remainder = bin_str[6..]

      [version, type, remainder]
    end
  end
end
