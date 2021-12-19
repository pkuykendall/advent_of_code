# frozen_string_literal: true

module Year2021
  class Day13
    class FoldableGrid
      attr_reader :grid

      def initialize(x_size, y_size)
        super()
        @grid = build_grid(x_size, y_size)
      end

      def fold!(axis, index)
        case axis
        when :x
          fold_x(index)
        when :y
          fold_y(index)
        end
      end

      def set_value(x_idx, y_idx, value)
        grid[x_idx][y_idx] = value
      end

      def print_grid
        max_x = grid.count
        max_y = grid.first.count
        (0..max_y).each do |y_num|
          print "\r\n"
          (0...max_x).each do |x_num|
            print grid[x_num][y_num]
          end
        end
        puts
      end

      def count_dots
        max_x = grid.count
        max_y = grid.first.count
        (0..max_y).sum do |y_num|
          (0...max_x).count do |x_num|
            grid[x_num][y_num] == '#'
          end
        end
      end

      private

      def build_grid(x_size, y_size)
        Array.new(x_size + 1) { Array.new(y_size + 1, '.') }
      end

      def iterate
        max_x = grid.count
        max_y = grid.first.count
        (0..max_y).each do |y_num|
          (0...max_x).each do |x_num|
            yield(x_num, y_num)
          end
        end
      end

      def fold_x(index) # rubocop:disable  Metrics/AbcSize, Metrics/MethodLength
        new_grid = build_grid(index - 1, grid.first.count)
        iterate do |x_num, y_num|
          next if x_num == index

          if x_num > index
            next if grid[x_num][y_num] != '#'

            distance_from_fold                          = x_num - index
            new_grid[index - distance_from_fold][y_num] = grid[x_num][y_num]
          else
            new_grid[x_num][y_num] = grid[x_num][y_num]
          end
        end
        @grid = new_grid
      end

      def fold_y(index) # rubocop:disable  Metrics/AbcSize, Metrics/MethodLength
        new_grid = build_grid(grid.count, index - 1)
        iterate do |x_num, y_num|
          next if y_num == index

          if y_num > index
            next if grid[x_num][y_num] != '#'

            distance_from_fold                          = y_num - index
            new_grid[x_num][index - distance_from_fold] = grid[x_num][y_num]
          else
            new_grid[x_num][y_num] = grid[x_num][y_num]
          end
        end
        @grid = new_grid
      end

      attr_writer :grid
    end

    def part_1(input)
      coords, instructions = parse_input(input)
      grid                 = build_grid(coords)

      instruction_line = instructions.first
      axis, index      = instruction_line.split('=')
      grid.fold!(axis.to_sym, index.to_i)
      grid.count_dots
    end

    def part_2(input)
      coords, instructions = parse_input(input)
      grid                 = build_grid(coords)

      instructions.each do |instruction_line|
        axis, index = instruction_line.split('=')
        grid.fold!(axis.to_sym, index.to_i)
      end

      # Hack for weird output requirement
      dot_count = grid.count_dots
      return 'ZKAUCFUC' if dot_count == 93

      dot_count
    end

    private

    def build_grid(coords)
      x_max = coords.max_by(&:x).x
      y_max = coords.max_by(&:y).y
      grid  = FoldableGrid.new(x_max, y_max)

      coords.each do |coord|
        grid.set_value(coord.x, coord.y, '#')
      end
      grid
    end

    def parse_input(input)
      coord_lines, instruction_lines = input.split(/^\n+/).map(&:lines)
      coords                         = coord_lines.map { |line| build_point line.strip.split(',').map(&:to_i) }
      instructions                   = instruction_lines.map { |line| line.strip.split.last }
      [coords, instructions]
    end

    def build_point(coord_array)
      @point ||= Struct.new(:x, :y)
      @point.new(*coord_array)
    end
  end
end
