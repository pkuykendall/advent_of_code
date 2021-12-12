# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2015::Day03 do
  let(:puzzle) { Year2015::Day03.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2015/03/input.txt')) }
  let(:example_input_1) do
    <<~EOF
      >
    EOF
  end
  let(:example_input_2) do
    <<~EOF
      ^>v<
    EOF
  end
  let(:example_input_3) do
    <<~EOF
      ^v^v^v^v^v
    EOF
  end
  let(:example_input_4) do
    <<~EOF
      ^v
    EOF
  end

  describe 'part 1' do
    it 'returns 2 for the example input 1' do
      expect(puzzle.part_1(example_input_1)).to eq(2)
    end

    it 'returns 4 for the example input 2' do
      expect(puzzle.part_1(example_input_2)).to eq(4)
    end

    it 'returns 2 for the example input 3' do
      expect(puzzle.part_1(example_input_3)).to eq(2)
    end

    it 'returns 2592 for my input' do
      expect(puzzle.part_1(input)).to eq(2592)
    end
  end

  describe 'part 2' do
    it 'returns 3 for the example input 4' do
      expect(puzzle.part_2(example_input_4)).to eq(3)
    end

    it 'returns 3 for the example input 2' do
      expect(puzzle.part_2(example_input_2)).to eq(3)
    end

    it 'returns 11 for the example input 3' do
      expect(puzzle.part_2(example_input_3)).to eq(11)
    end

    it 'returns 2360 for my input' do
      expect(puzzle.part_2(input)).to eq(2360)
    end
  end
end
