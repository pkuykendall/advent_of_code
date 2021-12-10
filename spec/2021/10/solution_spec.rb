# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day10 do
  let(:puzzle) { Year2021::Day10.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2021/10/input.txt')) }
  let(:example_input) do
    <<~EOF
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    EOF
  end

  describe 'part 1' do
    it 'returns 26397 for the example input' do
      expect(puzzle.part_1(example_input)).to eq(26_397)
    end

    it 'returns 339537 for my input' do
      expect(puzzle.part_1(input)).to eq(339_537)
    end
  end

  describe 'part 2' do
    it 'returns 288957 for the example input' do
      expect(puzzle.part_2(example_input)).to eq(288_957)
    end

    it 'returns 2412013412 for my input' do
      expect(puzzle.part_2(input)).to eq(2_412_013_412)
    end
  end
end
