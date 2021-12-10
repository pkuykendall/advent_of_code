# frozen_string_literal: true

require_relative '../../modules/color_output'
require 'matrix'
module Year2021
  class Day09
    class HeightMap < Array
      include ColorOutput

      Point = Struct.new(:x, :y, :value, :color) do
        def north = [x, y - 1]

        def south = [x, y + 1]

        def east = [x + 1, y]

        def west = [x - 1, y]

        def neighbors = [north, south, east, west]
      end

      def initialize(*several_variants)
        super
        each.with_index do |line, y_idx|
          line.each.with_index do |_value, x_idx|
            self[y_idx][x_idx] = Point.new(x_idx, y_idx, self[y_idx][x_idx].to_i, GREEN)
          end
        end
      end

      def find_low_points
        map(&method(:find_local_minima)).flatten
      end

      def find_basins
        find_low_points.map do |point|
          point.color = COLOR_PICKER.next
          bfs(point)
        end.reduce(:merge)
      end

      def print_minima_map
        puts
        each do |line|
          line.each do |point|
            color(point.color) { print point.value }
          end
          print "\r\n"
        end
      end

      def print_basin_map
        each do |line|
          line.each do |point|
            color = point.value == 9 ? RED : point.color
            color(color) { print point.value }
          end
          print "\r\n"
        end
      end

      private

      # rubocop:disable Metrics/MethodLength
      def bfs(point)
        queue   = [point]
        visited = { point => [] }
        loop do
          current = queue.pop
          eligible_neighbors(current).each do |neighbor|
            next if visited[point].include? neighbor

            neighbor.color = current.color
            visited[point] << neighbor
            queue << neighbor
          end
          break visited if queue.empty?
        end
      end
      # rubocop:enable Metrics/MethodLength

      def eligible_neighbors(point)
        neighbors_for_point(point).reject do |neighbor|
          neighbor.nil? || neighbor.value == 9
        end
      end

      def find_local_minima(line)
        line.select do |point|
          unless local_minima?(point)
            point.color = RED
            next point
          end
        end
      end

      def local_minima?(point)
        neighbors_for_point(point).any? do |neighbor|
          next unless neighbor

          neighbor.value <= point.value
        end
      end

      def neighbors_for_point(point)
        point.neighbors.map { |neighbor_coords| point_at(*neighbor_coords) }
      end

      def point_at(x_idx, y_idx)
        return nil if x_idx.negative? || y_idx.negative?
        return nil if y_idx >= length
        return nil if x_idx >= self[y_idx].length

        self[y_idx][x_idx]
      end
    end

    def part_1(input)
      height_map = generate_height_map(input)
      low_points = height_map.find_low_points
      height_map.print_minima_map
      low_points.map { |point| point.value.to_i + 1 }.sum
    end

    def part_2(input)
      height_map = generate_height_map(input)
      basins     = height_map.find_basins
      height_map.print_basin_map
      basins.values.max_by(3, &:count).map(&:count).reduce(:*)
    end

    private

    def generate_height_map(input)
      height_map = input.lines.map do |line|
        line.strip.chars
      end
      HeightMap.new(height_map)
    end
  end
end
