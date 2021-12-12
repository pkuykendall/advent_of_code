# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day11 do
  let(:puzzle) { Year2021::Day11.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/11/input.txt')) }
  let(:example_input) do
    <<~EOF
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    EOF
  end

  describe 'part 1' do
    it 'returns 1656 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(1656)
    end

    it 'returns 1743 for my input' do
      expect(puzzle.part_1(input)).to eq(1743)
    end
  end

  describe 'part 2' do
    it 'returns 195 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(195)
    end

    it 'returns 364 for my input' do
      expect(puzzle.part_2(input)).to eq(364)
    end
  end
end
