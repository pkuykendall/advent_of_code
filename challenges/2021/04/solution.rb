# frozen_string_literal: true

require 'set'
module Year2021
  class Day04
    def part_1(input)
      called_numbers, bingo_sheets = parse_input(input)
      called_numbers.each.with_object([]) do |num, previous|
        previous << num
        winner = bingo_sheets.find do |sheet|
          clear_matches(num, sheet)
          break sheet if winning_sheet?(sheet)
        end
        break sheet_score(num, winner) if winner
      end
    end

    def part_2(input)
      called_numbers, bingo_sheets = parse_input(input)
      called_numbers.each do |num|
        winner = bingo_sheets.find do |sheet|
          clear_matches(num, sheet)
          break sheet if bingo_sheets.count == 1 && winning_sheet?(sheet)
        end

        break sheet_score(num, winner) if winner

        bingo_sheets.reject!(&method(:winning_sheet?))
      end
    end

    private

    def sheet_score(num, winner)
      winner.lines.flatten.sum * num
    end

    def winning_sheet?(sheet)
      sheet.lines.any?(&:empty?) || sheet.columns.any?(&:empty?)
    end

    def clear_matches(num, sheet)
      sheet.lines.find { |line| line.delete(num) }
      sheet.columns.find { |col| col.delete(num) }
    end

    def parse_input(input)
      split_input    = input.split(/^\n+/)
      called_numbers = split_input[0].strip.split(',').map!(&:to_i)
      bingo_sheets   = split_input[1..].map(&method(:build_sheet))
      [called_numbers, bingo_sheets]
    end

    def build_sheet(sheet)
      lines     = sheet.split("\n").map!(&:split)
      columns   = lines.transpose
      new_sheet = Struct.new(:lines, :columns)
      new_sheet.new(
        lines.map { |line| line.map!(&:to_i) },
        columns.map { |col| col.map!(&:to_i) }
      )
    end
  end
end
