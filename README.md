# Advent of Code Solutions

Ruby solutions for [Advent of Code](https://adventofcode.com/) challenges using [aoc_rb](https://github.com/pacso/aoc_rb).

## Setup

```bash
bundle install
cp .env-template .env
# Add your AOC_COOKIE to .env
```

## Usage

Prepare a new puzzle (defaults to today):
```bash
./bin/aoc prep
./bin/aoc prep -y 2023 -d 5  # Specific date
```

Run a solution:
```bash
./bin/aoc exec
./bin/aoc exec 2023 5  # Specific date
```

Run tests:
```bash
./bin/aoc spec
bundle exec rspec  # All tests
```

View output without submitting:
```bash
./bin/aoc output
```

## Structure

```
challenges/
├── YEAR/DAY/
│   ├── solution.rb    # Solution implementation
│   ├── input.txt      # Puzzle input (not in git)
│   ├── part_1.md      # Problem description (not in git)
│   └── part_2.md      # Problem description (not in git)
├── classes/           # Shared classes (Grid, Point, etc.)
├── modules/           # Shared modules
└── shared/            # Base solution class
```

## Note

Problem descriptions and puzzle inputs are excluded from version control per Advent of Code's [copyright policy](https://adventofcode.com/about).
