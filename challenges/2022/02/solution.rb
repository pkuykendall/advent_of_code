# frozen_string_literal: true

module Year2022
  class Day02 < Solution
    ROCK     = 1
    PAPER    = 2
    SCISSORS = 3
    LOSS     = 0
    DRAW     = 3
    WIN      = 6

    SCORES = {
      A: {
        X: (ROCK + DRAW),
        Y: (PAPER + WIN),
        Z: (SCISSORS + LOSS)
      },
      B: {
        X: (ROCK + LOSS),
        Y: (PAPER + DRAW),
        Z: (SCISSORS + WIN)
      },
      C: {
        X: (ROCK + WIN),
        Y: (PAPER + LOSS),
        Z: (SCISSORS + DRAW)
      }
    }.freeze

    # X - loss
    # Y - draw
    # Z - win
    PLAYS = {
      A: {
        X: (SCISSORS + LOSS),
        Y: (ROCK + DRAW),
        Z: (PAPER + WIN)
      },
      B: {
        X: (ROCK + LOSS),
        Y: (PAPER + DRAW),
        Z: (SCISSORS + WIN)
      },
      C: {
        X: (PAPER + LOSS),
        Y: (SCISSORS + DRAW),
        Z: (ROCK + WIN)
      }
    }.freeze

    def part_1
      data.sum do |theirs, mine|
        SCORES[theirs][mine]
      end
    end

    def part_2
      data.sum do |theirs, mine|
        PLAYS[theirs][mine]
      end
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.split.map(&:to_sym)
    end
  end
end
