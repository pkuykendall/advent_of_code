# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day07 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/07/input.txt')) }
  let(:example_input) do
    <<~EOF
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
    EOF
  end

  describe 'part 1' do
    it 'returns nil for the example input' do
      expect(described_class.part_1(example_input)).to eq(95_437)
    end

    it 'returns nil for my input' do
      expect(described_class.part_1(input)).to eq(nil)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(described_class.part_2(example_input)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(described_class.part_2(input)).to eq(nil)
    end
  end
end
