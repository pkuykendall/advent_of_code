# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day02 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/02/input.txt')) }
  let(:example_input) do
    <<~EOF
      A Y
      B X
      C Z
    EOF
  end

  describe 'part 1' do
    it 'returns nil for the example input' do
      expect(described_class.part_1(example_input)).to eq(15)
    end

    it 'returns nil for my input' do
      expect(described_class.part_1(input)).to eq(13_924)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(described_class.part_2(example_input)).to eq(12)
    end

    it 'returns nil for my input' do
      expect(described_class.part_2(input)).to eq(13_448)
    end
  end
end
