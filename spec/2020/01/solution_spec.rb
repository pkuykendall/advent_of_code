# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2020::Day01 do
  let(:puzzle) { Year2020::Day01.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2020/01/input.txt')) }
  let(:example_input) do
    <<~EOF
      1721
      979
      366
      299
      675
      1456
    EOF
  end

  describe 'part 1' do
    it 'returns 514579 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(514_579)
    end

    it 'returns 972576 for my input' do
      expect(puzzle.part_1(input)).to eq(972_576)
    end
  end

  describe 'part 2' do
    it 'returns 241861950 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(241_861_950)
    end

    it 'returns 199300880 for my input' do
      expect(puzzle.part_2(input)).to eq(199_300_880)
    end
  end
end
