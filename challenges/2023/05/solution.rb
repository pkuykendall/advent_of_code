# frozen_string_literal: true

module Year2023
  class Day05 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      data
    end

    def part_2
      nil
    end

    private

    attr_accessor :master_mapping, :seeds

    # Hash.new { |hash, key| hash[key] = key }
    # Hash[(98...102).to_a.zip((50...54).to_a)]
    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    def process_dataset(set)
      set
    end

    def data
      @data ||= begin
        @master_mapping = {}
        @input.split(/\n{2}/).each do |section|
          split_section = section.split(/(\smap)?:(\n)?/)
          section_type = split_section.first
          case section_type
          when 'seeds'
            @seeds = split_section.last.split.map(&:to_i)
            puts "Seeds: #{seeds}"
          else
            master_mapping[section_type] = Hash.new { |hash, key| hash[key] = key }
            split_section.last.split("\n").each do |map_str|
              mapping = map_str.split.map(&:to_i)
              destination_range = (mapping[0]...(mapping[0] + mapping[2]))
              source_range = (mapping[1]...(mapping[1] + mapping[2]))
              master_mapping[section_type].merge! Hash[source_range.to_a.zip(destination_range.to_a)]
            end
            puts section
          end
          puts section_type
        end
        processed = @input.lines(chomp: true).map do |line|
          process_input line
        end

        processed.length == 1 ? processed.first : process_dataset(processed)
      end
    end
  end
end
