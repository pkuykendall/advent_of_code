# frozen_string_literal: true

module Year2023
  class Day04 < Solution
    class << self
      attr_accessor :outcome_class
    end

    def part_1
      data.values.sum(&:points)
    end

    def part_2
      total_wins = Hash.new(0)
      data.reverse_each do |game_number, outcome|
        next unless outcome.winner?

        next_card = outcome.card_number + 1
        wins = 0
        outcome.winning_count.times do
          wins += 1
          wins += total_wins[next_card]
          next_card += 1
        end
        total_wins[game_number] = wins
      end
      data.values.count + total_wins.values.sum
    end

    private

    self.outcome_class = Struct.new(:card_number, :winner?, :winning_count, :points)

    CARD_REGEX = /^Card\s*(?<card>\d+):\s*(?<winning_numbers>(\d+\s+)+).*\|\s*(?<numbers>(\d+\s*)+)$/

    # Processes the dataset as a whole
    def process_dataset(set)
      set.each.with_object({}) do |line, card_hash|
        matches = line.match(CARD_REGEX)
        winners = (matches[:winning_numbers].split & matches[:numbers].split)

        card_number            = matches[:card].to_i
        card_hash[card_number] = self.class.outcome_class.new(
          card_number,
          !winners.empty?,
          winners.count,
          (2**(winners.count - 1)).floor
        )
      end
    end
  end
end
