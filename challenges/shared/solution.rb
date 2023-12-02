# frozen_string_literal: true

# frozen_string_literal: true %>
class Solution
  def self.part_1(*input)
    new(*input).part_1
  end

  def self.part_2(*input)
    new(*input).part_2
  end

  # @param [String] input Full challenge input text
  def initialize(input)
    @input = input
  end

  def data
    @data ||= begin
      processed = @input.lines(chomp: true).map do |line|
        process_input line
      end

      processed.length == 1 ? processed.first : process_dataset(processed)
    end
  end

  private

  # @param [String] line
  def process_input(line)
    line
  end

  # @param [Array<String>] set
  def process_dataset(set)
    set
  end
end
