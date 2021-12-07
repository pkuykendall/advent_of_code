# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day07 do
  let(:puzzle) { Year2021::Day07.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/07/input.txt')) }
  let(:example_input) do
    <<~EOF
      16,1,2,0,4,2,7,1,2,14
    EOF
  end

  describe 'part 1' do
    it 'returns 37 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(37)
    end

    it 'returns 328187 for my input' do
      expect(puzzle.part_1(input)).to eq(328_187)
    end
  end

  describe 'part 2' do
    it 'returns 168 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(168)
    end

    it 'returns 91257582 for my input' do
      expect(puzzle.part_2(input)).to eq(91_257_582)
    end
  end
end
