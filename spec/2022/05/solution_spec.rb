# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day05 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/05/input.txt')) }
  # rubocop:disable Layout/TrailingWhitespace
  let(:example_input) do
    <<~EOF
          [D]    
      [N] [C]    
      [Z] [M] [P]
       1   2   3 
      
      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
    EOF
  end
  # rubocop:enable Layout/TrailingWhitespace

  describe 'part 1' do
    it 'returns nil for the example input' do
      expect(described_class.part_1(example_input)).to eq('CMZ')
    end

    it 'returns nil for my input' do
      expect(described_class.part_1(input)).to eq('VPCDMSLWJ')
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(described_class.part_2(example_input)).to eq('MCD')
    end

    it 'returns nil for my input' do
      expect(described_class.part_2(input)).to eq('TPWCGNCCG')
    end
  end
end
