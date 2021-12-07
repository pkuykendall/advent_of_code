# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2015::Day01 do
  let(:puzzle) { Year2015::Day01.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2015/01/input.txt')) }
  let(:example_input_1) { '(())' }
  let(:example_input_2) { '()()' }
  let(:example_input_3) { '(((' }
  let(:example_input_4) { '(()(()(' }
  let(:example_input_5) { '))(((((' }
  let(:example_input_6) { '())' }
  let(:example_input_7) { '))(' }
  let(:example_input_8) { ')))' }
  let(:example_input_9) { ')())())' }

  let(:example_input_10) { ')' }
  let(:example_input_11) { '()())' }

  describe 'part 1' do
    it 'returns 0 for the example input 1' do
      expect(puzzle.part_1(example_input_1)).to eq(0)
    end

    it 'returns 0 for the example input 2' do
      expect(puzzle.part_1(example_input_2)).to eq(0)
    end

    it 'returns 3 for the example input 3' do
      expect(puzzle.part_1(example_input_3)).to eq(3)
    end

    it 'returns 3 for the example input 4' do
      expect(puzzle.part_1(example_input_4)).to eq(3)
    end

    it 'returns 3 for the example input 5' do
      expect(puzzle.part_1(example_input_5)).to eq(3)
    end

    it 'returns -1 for the example input 6' do
      expect(puzzle.part_1(example_input_6)).to eq(-1)
    end

    it 'returns -1 for the example input 7' do
      expect(puzzle.part_1(example_input_7)).to eq(-1)
    end

    it 'returns -3 for the example input 8' do
      expect(puzzle.part_1(example_input_8)).to eq(-3)
    end

    it 'returns -3 for the example input 9' do
      expect(puzzle.part_1(example_input_9)).to eq(-3)
    end

    it 'returns 74 for my input' do
      expect(puzzle.part_1(input)).to eq(74)
    end
  end

  describe 'part 2' do
    it 'returns 1 for the example input 10' do
      expect(puzzle.part_2(example_input_10)).to eq(1)
    end

    it 'returns 5 for the example input 11' do
      expect(puzzle.part_2(example_input_11)).to eq(5)
    end

    it 'returns 1795 for my input' do
      expect(puzzle.part_2(input)).to eq(1795)
    end
  end
end
