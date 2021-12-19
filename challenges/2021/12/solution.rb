# frozen_string_literal: true

require 'matrix'
require 'set'
module Year2021
  class Day12
    class Graph
      class Node
        attr_reader :location, :size

        def initialize(location)
          super()
          @location = location
          @size     = location == location.upcase ? :large : :small
        end

        def reset!
          @visited = false
        end

        def visit!
          @visited = true
        end

        def end?
          location == 'end'
        end

        def safe_for_travel?
          case location
          when 'start'
            false
          when 'end'
            true
          else
            size == :large || !@visited
          end
        end

        def eql?(other)
          other.class == self.class &&
            other.location == location
        end

        alias == eql?

        def hash
          location.hash
        end

        private

        attr_reader :visited
      end

      attr_accessor :edges

      def initialize
        super
        @edges      = {} # Default Set.new not helpful here
        @start_node = Node.new('start')
      end

      def add_edge(from, to)
        from_node, to_node = [from, to].map { |var| Node.new(var) }

        edges[from_node] ||= Set.new
        edges[from_node].add to_node

        edges[to_node] ||= Set.new
        edges[to_node].add from_node
      end

      def count_paths
        edges[@start_node].sum do |node|
          find_paths(node, limit: 1).count
        end
      end

      def count_paths_part_2
        edges[@start_node].sum do |node|
          find_paths(node, limit: 2).count
        end
      end

      private

      def find_paths(start_point, search_path = nil, limit: 1)
        path = Struct.new(:point, :path)

        starting_path  = search_path || [start_point.location]
        node_stack     = [path.new(start_point, starting_path)]
        complete_paths = []

        depth_first_search(complete_paths, limit, node_stack, path)
        complete_paths
      end

      def depth_first_search(complete_paths, limit, node_stack, path) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        while node_stack.any?
          current_node = node_stack.shift
          point        = current_node.point
          current_path = current_node.path
          if current_node.point.end?
            complete_paths << current_path
            next
          end

          edges[point]&.each do |dest|
            next unless dest.safe_for_travel?
            next unless can_visit_small_cave?(current_path, dest, limit: limit)

            node_stack << path.new(dest, (current_path + [dest.location]))
          end
        end
      end

      def can_visit_small_cave?(current_path, dest, limit: 1)
        return true if dest.end?
        return true if dest.size == :large

        if limit > 1
          cave_visitable?(current_path, dest, limit)
        else
          current_path.count(dest.location) < limit
        end
      end

      def cave_visitable?(current_path, dest, limit)
        current_path_count = current_path.count(dest.location)
        return true if current_path_count.zero?
        return false if current_path_count > limit - 1

        small_caves = current_path.reject do |location|
          location == location.upcase
        end

        return false if small_caves.tally.values.any? { |val| (val >= limit) }

        current_path_count <= limit - 1
      end
    end

    def part_1(input)
      graph = Graph.new
      populate_graph(graph, input)
      graph.count_paths
    end

    def part_2(input)
      graph = Graph.new
      populate_graph(graph, input)
      graph.count_paths_part_2
    end

    private

    def populate_graph(graph, input)
      parse_input(input).each { |edge| graph.add_edge(*edge) }
    end

    def parse_input(input)
      input.lines.map { |line| line.strip.split('-') }
    end
  end
end
