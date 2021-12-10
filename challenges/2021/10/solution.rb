# frozen_string_literal: true

module Year2021
  class Day10
    include ArrayOperations

    PART1_SCORE = {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25_137
    }.freeze
    PART2_SCORE = {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }.freeze
    OPENING_CHARS  = %w=( [ { <=.freeze
    CLOSING_CHARS  = %w=) ] } >=.freeze
    MATCHING_PAIRS = OPENING_CHARS.zip(CLOSING_CHARS).map(&:join).freeze

    def part_1(input)
      result = remove_valid_pairs(input)
      result.map!(&method(:find_closing_char))
      result.compact!
      result.map { |char| PART1_SCORE[char] }.sum
    end

    def part_2(input)
      result = remove_valid_pairs(input)
      result.reject!(&method(:find_closing_char))
      result.compact!

      reverse = result.map(&:reverse).map { |r_line| r_line.each_char.map(&method(:invert_char)).join }
      middle_value reverse.map(&method(:score_part_2)).sort
    end

    private

    def find_closing_char(line)
      line.each_char.find { |char| CLOSING_CHARS.include? char }
    end

    def remove_valid_pairs(input)
      input.lines.map do |line|
        tmp_line = line.dup.strip
        loop do
          start = tmp_line.dup
          strip_pairs(tmp_line)
          break if start == tmp_line
        end
        tmp_line
      end
    end

    def strip_pairs(tmp_line)
      MATCHING_PAIRS.each do |matching_pair|
        tmp_line.gsub!(matching_pair, '')
      end
    end

    def invert_char(char)
      case char
      when ->(chr) { OPENING_CHARS.include? chr }
        CLOSING_CHARS[OPENING_CHARS.index(char)]
      when ->(chr) { CLOSING_CHARS.include? chr }
        OPENING_CHARS[CLOSING_CHARS.index(char)]
      end
    end

    def score_part_2(line)
      line.each_char.map.inject(0) do |score, char|
        (score * 5) + PART2_SCORE[char]
      end
    end
  end
end
