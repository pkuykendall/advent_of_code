# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2020::Day03 do
  let(:puzzle) { Year2020::Day03.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2020/03/input.txt")) }
  let(:example_input) {
    <<~EOF
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    EOF
  }

  describe "part 1" do
    it "returns 7 for the example input" do
      expect(puzzle.part_1(example_input)).to eq(7)
    end

    it "returns 276 for my input" do
      expect(puzzle.part_1(input)).to eq(276)
    end
  end

  describe "part 2" do
    it "returns 336 for the example input" do
      expect(puzzle.part_2(example_input)).to eq(336)
    end

    it "returns 7812180000 for my input" do
      expect(puzzle.part_2(input)).to eq(7812180000)
    end
  end
end
