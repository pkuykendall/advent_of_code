# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day16 do
  let(:puzzle) { Year2021::Day16.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/16/input.txt')) }
  let(:example_input_1) do
    <<~EOF
      D2FE28
    EOF
  end

  describe 'part 1' do
    it 'returns 2021 for the example input' do
      expect(puzzle.part_1(example_input_1)).to eq(2021)
    end

    it 'returns nil for my input' do
      expect(puzzle.part_1(input)).to eq(nil)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(puzzle.part_2(example_input_1)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(puzzle.part_2(input)).to eq(nil)
    end
  end
end
