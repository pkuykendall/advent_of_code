# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day05 do
  let(:puzzle) { Year2021::Day05.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/05/input.txt')) }
  let(:example_input) do
    <<~EOF
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    EOF
  end

  describe 'part 1' do
    it 'returns 5 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(5)
    end

    it 'returns 5608 for my input' do
      expect(puzzle.part_1(input)).to eq(5608)
    end
  end

  describe 'part 2' do
    it 'returns 12 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(12)
    end

    it 'returns 20299 for my input' do
      expect(puzzle.part_2(input)).to eq(20_299)
    end
  end
end
