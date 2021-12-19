# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day12 do
  let(:puzzle) { Year2021::Day12.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/12/input.txt')) }
  let(:example_input_1) do
    <<~EOF
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    EOF
  end

  describe 'part 1' do
    it 'returns 10 for the example input 1' do
      expect(puzzle.part_1(example_input_1)).to eq(10)
    end

    it 'returns 3576 for my input' do
      expect(puzzle.part_1(input)).to eq(3576)
    end
  end

  describe 'part 2' do
    it 'returns 36 for the example input' do
      expect(puzzle.part_2(example_input_1)).to eq(36)
    end

    it 'returns 84271 for my input' do
      expect(puzzle.part_2(input)).to eq(84_271)
    end
  end
end
