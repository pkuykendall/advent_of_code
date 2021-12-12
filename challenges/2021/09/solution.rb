# frozen_string_literal: true

require_relative '../../classes/grid'
require 'matrix'
module Year2021
  class Day09
    class HeightMap < Grid
      self.bfs_eligibility_proc = lambda { |point|
        return false if point.nil?

        point.value <= 8
      }

      def find_low_points
        map(&method(:find_local_minima)).flatten
      end

      def find_basins
        find_low_points.map do |point|
          point.color = COLOR_PICKER.next
          bfs(point) do |current, visited, queue, starting_point|
            find_basin_neighbors(current, queue, starting_point, visited)
          end
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

      def find_basin_neighbors(current, queue, starting_point, visited)
        eligible_neighbors(current, false).each do |neighbor|
          next if visited[starting_point].include? neighbor

          neighbor.color = current.color
          visited[starting_point] << neighbor
          queue << neighbor
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
    end

    def part_1(input, print: false)
      height_map = generate_height_map(input)
      low_points = height_map.find_low_points
      height_map.print_minima_map if print
      low_points.map { |point| point.value.to_i + 1 }.sum
    end

    def part_2(input, print: false)
      height_map = generate_height_map(input)
      basins     = height_map.find_basins
      height_map.print_basin_map if print
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
