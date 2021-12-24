# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day14 do
  let(:puzzle) { Year2021::Day14.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/14/input.txt')) }
  let(:example_input) do
    <<~EOF
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    EOF
  end

  describe 'part 1' do
    it 'returns 1588 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(1588)
    end

    it 'returns 3406 for my input' do
      expect(puzzle.part_1(input)).to eq(3406)
    end
  end

  describe 'part 2' do
    it 'returns 2188189693529 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(2_188_189_693_529)
    end

    it 'returns 3941782230241 for my input' do
      expect(puzzle.part_2(input)).to eq(3_941_782_230_241)
    end
  end
end
