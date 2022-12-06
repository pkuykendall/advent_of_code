# frozen_string_literal: true

require 'ostruct'
module Year2021
  class Day03
    def part_1(input)
      lines = parse_lines(input)
      tally = tally_columns(lines)
      gamma = find_gamma_rate(tally)
      invert_convert_and_multiply(gamma)
    end

    def part_2(input)
      lines          = parse_lines(input)
      tally          = tally_columns(lines)
      oxygen         = find_gas_rating(lines, tally, gas_type: :oxygen).join
      carbon_dioxide = find_gas_rating(lines, tally, gas_type: :carbon_dioxide).join
      oxygen.to_i(2) * carbon_dioxide.to_i(2)
    end

    private

    def find_gamma_rate(tally)
      tally.map { |tal| tal.key(tal.values.max) }
    end

    def parse_lines(input)
      input.lines.map { |line| line.scan(/\w/) }
    end

    def invert_convert_and_multiply(bin_value)
      bin_value_str     = bin_value.join
      inverse_value_str = bin_value_str.tr('01', '10') # heh
      bin_value_str.to_i(2) * inverse_value_str.to_i(2)
    end

    def find_gas_rating(lines, tally, gas_type:)
      gas_type_options = options_for_gas_type(gas_type)
      tally.each.with_index.with_object(lines.dup) do |(_, idx), selected|
        break selected if selected.count == 1

        column_tally = tally_columns(selected)[idx]
        selected.select! { |line| line[idx] == gas_value(column_tally, gas_type_options) }
      end
    end

    def gas_value(column_tally, gas_type_options)
      if column_tally.values.uniq.count == 1
        gas_type_options.default
      else
        column_tally.key(column_tally.values.public_send(gas_type_options.selector))
      end
    end

    def options_for_gas_type(gas_type)
      gas_type_option = Struct.new(:selector, :default)
      case gas_type
      when :oxygen
        gas_type_option.new(:max, '1')
      when :carbon_dioxide
        gas_type_option.new(:min, '0')
      end
    end

    def tally_columns(lines)
      lines.transpose.map(&:tally)
    end
  end
end
