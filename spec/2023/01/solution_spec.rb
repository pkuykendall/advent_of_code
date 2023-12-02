# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day01 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2023/01/input.txt')) }
  let(:example_input) do
    <<~EOF
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    EOF
  end
  let(:example_input_2) do
    <<~EOF
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    EOF
  end

  describe 'part 1' do
    it 'returns 77 for the example input' do
      expect(described_class.part_1(example_input)).to eq(142)
    end

    it 'returns 54927 for my input' do
      expect(described_class.part_1(input)).to eq(54_927)
    end
  end

  describe 'part 2' do
    it 'returns 281 for the example input' do
      expect(described_class.part_2(example_input_2)).to eq(281)
    end

    it 'returns 54581 for my input' do
      expect(described_class.part_2(input)).to eq(54_581)
    end
  end
end
