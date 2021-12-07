# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2015::Day02 do
  let(:puzzle) { Year2015::Day02.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2015/02/input.txt')) }
  let(:example_input_1) { '2x3x4' }
  let(:example_input_2) { '1x1x10' }

  describe 'part 1' do
    it 'returns 58 for the example input 1' do
      expect(puzzle.part_1(example_input_1)).to eq(58)
    end

    it 'returns 43 for the example input 2' do
      expect(puzzle.part_1(example_input_2)).to eq(43)
    end

    it 'returns 1586300 for my input' do
      expect(puzzle.part_1(input)).to eq(1_586_300)
    end
  end

  describe 'part 2' do
    it 'returns 34 for the example input 1' do
      expect(puzzle.part_2(example_input_1)).to eq(34)
    end

    it 'returns 14 for the example input 1' do
      expect(puzzle.part_2(example_input_2)).to eq(14)
    end

    it 'returns 3737498 for my input' do
      expect(puzzle.part_2(input)).to eq(3_737_498)
    end
  end
end
