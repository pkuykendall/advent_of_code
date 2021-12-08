# frozen_string_literal: true

module Year2021
  class Day08
    UNIQUE_SEGMENT_COUNTS = {
      2 => 1,
      3 => 7,
      4 => 4,
      7 => 8
    }.freeze

    def part_1(input)
      parsed_input = input.lines.map(&method(:parse_line))
      parsed_input.map do |entry|
        entry.output.select do |item|
          UNIQUE_SEGMENT_COUNTS[item.length]
        end
      end.flatten.count
    end

    def part_2(input)
      parsed_input = input.lines.map(&method(:parse_line))
      parsed_input.map do |entry|
        known_values = populate_mapping((entry.input + entry.output))
        find_output_number(entry, known_values)
      end.flatten.sum
    end

    private

    def find_output_number(entry, known_values)
      entry.output.map do |ent|
        find_segment(ent, known_values).keys.first
      end.join.to_i
    end

    def find_segment(entry, known_values)
      known_values.select { |_k, v| entry == v }
    end

    def populate_mapping(all_entries)
      known_values = populate_unique_entries!(all_entries, {})
      populate_six_segment_entries!(all_entries, known_values)
      populate_five_segment_entries!(all_entries, known_values)
    end

    def parse_line(line)
      parsed = Struct.new(:input, :output)
      parsed.new(*line.split('|').map! do |side|
        side.strip.split.map! do |entry|
          entry.chars.to_set
        end
      end)
    end

    def populate_unique_entries!(entries, hsh)
      entries.each.with_object(hsh) do |entry, values|
        known = UNIQUE_SEGMENT_COUNTS[entry.count]
        values[known] = entry if known
        values
      end
    end

    def populate_six_segment_entries!(entries, known_values)
      entries.each.with_object(known_values) do |entry, values|
        next values unless entry.length == 6

        map_six_segment_entry(entry, values)
      end
    end

    def map_six_segment_entry(entry, values)
      case entry
      when ->(ent) { ent.superset?(values[4]) }
        values[9] = entry
      when ->(ent) { !ent.superset?(values[1]) }
        values[6] = entry
      else
        values[0] = entry
      end
      values
    end

    def populate_five_segment_entries!(entries, known_values)
      entries.each.with_object(known_values) do |entry, values|
        next values unless entry.length == 5

        map_five_segment_entry(entry, values)
      end
    end

    def map_five_segment_entry(entry, values)
      case entry
      when ->(ent) { ent.subset?(values[6]) }
        values[5] = entry
      when ->(ent) { ent.superset?(values[1]) }
        values[3] = entry
      else
        values[2] = entry
      end
      values
    end
  end
end
