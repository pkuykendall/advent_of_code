# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2021::Day06 do
  let(:puzzle) { Year2021::Day06.new }
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2021/06/input.txt")) }
  let(:example_input) {
    <<~EOF
      3,4,3,1,2
    EOF
  }

  describe "part 1" do
    it "returns 5934 for the example input" do
      expect(puzzle.part_1(example_input)).to eq(5934)
    end

    it "returns 350917 for my input" do
      expect(puzzle.part_1(input)).to eq(350917)
    end
  end

  describe "part 2" do
    it "returns 26984457539 for the example input" do
      expect(puzzle.part_2(example_input)).to eq(26984457539)
    end

    it "returns 1592918715629 for my input" do
      expect(puzzle.part_2(input)).to eq(1592918715629)
    end
  end
end
