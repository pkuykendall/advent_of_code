# frozen_string_literal: true

require_relative '../../classes/grid'

module Year2021
  class Day15
    class DijkstraGrid < Grid
      INFINITY = 1 << 64
      attr_reader :graph, :nodes

      class DijkstraPoint < Grid::Point
        attr_accessor :name, :distance, :previous

        def initialize(x_idx, y_idx, value, color)
          super(x_idx, y_idx, value, color)
          @name = "#{x_idx},#{y_idx}"
        end
      end

      self.point_class = DijkstraPoint

      def initialize(*several_variants)
        super
        @graph = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
        @nodes = Set.new
      end

      def shortest_path_cost(source = '0,0', target = nil)
        target ||= "#{length - 1},#{first.length - 1}"

        connect_points!
        distances = dijkstra source
        distances[target]
      end

      private

      def dijkstra(source) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        distance, previous = build_maps

        distance[source] = 0 # Distance from source to source

        queue = Set.new
        queue << source

        until queue.empty?
          u = queue.min_by { |n| distance[n] }

          break if distance[u] == INFINITY

          queue.delete(u)

          graph[u].each_key do |vertex|
            alt = distance[u] + graph[u][vertex]

            next unless alt < distance[vertex]

            distance[vertex] = alt
            previous[vertex] = u # A shorter path to v has been found
            queue << vertex
          end

        end
        distance
      end

      def build_maps
        distance = {}
        previous = {}
        nodes.each do |node|
          # initialization
          distance[node] = INFINITY # Unknown distance from source to vertex
          previous[node] = -1 # Previous node in optimal path from source
        end
        [distance, previous]
      end

      def connect_points!
        return if nodes.any?

        iterate_points do |point|
          point_name = point.name
          point.neighbors.each do |neighbor_coords|
            neighbor = point_at(*neighbor_coords)
            next unless neighbor

            graph[point_name][neighbor.name] = neighbor.value
          end
          nodes << point_name
        end
      end
    end

    def part_1(input)
      grid = DijkstraGrid.new(parse_input(input))
      grid.shortest_path_cost
    end

    def part_2(input)
      grid = DijkstraGrid.new(parse_input_2(input))
      grid.shortest_path_cost
    end

    private

    def parse_input(input)
      input.lines.map(&:strip).map { |line| line.chars.map(&:to_i) }
    end

    def parse_input_2(input) # rubocop:disable Metrics/MethodLength
      base_input = parse_input(input)
      new_input  = []
      5.times do |vert_times|
        base_input.each do |line|
          new_line = []
          4.times.each_with_object([]) do |horizontal_times, memo|
            build_new_line(horizontal_times, line, memo, new_line, vert_times)
          end
          new_input << new_line.flatten
        end
      end
      new_input
    end

    def build_new_line(horizontal_times, line, memo, new_line, vert_times)
      tmp_line = line.dup.map { |val| safely_increment(val, vert_times) }
      memo.append(*tmp_line.dup) if memo.empty?
      new_line << tmp_line.dup if horizontal_times.zero?
      memo.map! do |point|
        safely_increment(point, 1)
      end
      new_line << memo.dup
      memo
    end

    def safely_increment(*numbers)
      sum = Array(numbers).sum
      mod = sum > 10 ? 1 : 0
      val = sum % 10

      if val.zero?
        1 + mod
      else
        val + mod
      end
    end
  end
end
