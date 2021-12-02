# frozen_string_literal: true

module Year2020
  class Day04
    REQUIRED_ATTRS = %w[byr iyr eyr hgt hcl ecl pid].freeze
    ATTRS          = REQUIRED_ATTRS + [:cid].freeze

    class Passport
      attr_accessor(*ATTRS)

      def initialize(hash = {})
        hash.each { |k, v| public_send("#{k}=", v) }
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def valid?
        return false unless byr_valid?
        return false unless iyr_valid?
        return false unless eyr_valid?
        return false unless hgt_valid?
        return false unless hcl_valid?
        return false unless ecl_valid?
        return false unless pid_valid?

        true
      end
      # rubocop:enable Metrics/CyclomaticComplexity

      private

      def eyr_valid?
        number_in_range?(eyr.to_i, 2020, 2030)
      end

      def iyr_valid?
        number_in_range?(iyr.to_i, 2010, 2020)
      end

      def byr_valid?
        number_in_range?(byr.to_i, 1920, 2002)
      end

      def pid_valid?
        pid&.match?(/^[0-9]{9}$/)
      end

      def ecl_valid?
        ecl&.match?(/^(amb|blu|brn|gry|grn|hzl|oth)$/)
      end

      def hcl_valid?
        hcl&.match?(/^#([0-9a-f]){6}$/)
      end

      def number_in_range?(number, start_val, end_val)
        start_val <= number && number <= end_val
      end

      def hgt_valid?
        matches = hgt&.match(/(?<value>\d+)(?<type>cm|in)/)
        return false unless matches

        case matches[:type]
        when 'cm'
          number_in_range?(matches[:value].to_i, 150, 193)
        when 'in'
          number_in_range?(matches[:value].to_i, 59, 76)
        else
          false
        end
      end
    end

    def part_1(input)
      parse_passports(input).count do |passport|
        (REQUIRED_ATTRS - passport.keys).empty?
      end
    end

    def part_2(input)
      passports = parse_passports(input).map { |p| Passport.new(p) }
      passports.count(&:valid?)
    end

    private

    def parse_passports(input)
      passports = input.split(/^\n+/)
      parsed    = passports.map { |passport| passport.split.map!(&:strip) }
      parsed.map do |passport|
        passport.map do |entry|
          entry.split(':')
        end.to_h
      end
    end
  end
end
