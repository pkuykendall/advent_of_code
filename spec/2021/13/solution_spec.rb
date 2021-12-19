# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day13 do
  let(:puzzle) { Year2021::Day13.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/13/input.txt')) }
  let(:example_input) do
    <<~EOF
      change
      me
    EOF
  end

  describe 'part 1' do
    it 'returns nil for the example input' do
      expect(puzzle.part_1(example_input)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(puzzle.part_1(input)).to eq(nil)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(puzzle.part_2(example_input)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(puzzle.part_2(input)).to eq(nil)
    end
  end
end