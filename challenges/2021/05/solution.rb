# frozen_string_literal: true

module Year2021
  class Day05
    class CoordinatePlane
      attr_reader :grid

      def initialize
        super
        @grid = CoordinateHash.new
      end

      def add_line(line, allow_diag: false)
        traverse_line(line, allow_diag: allow_diag)
      end

      def overlapped_points
        grid.map { |column| column[1].values.count { |val| val > 1 } }.sum
      end

      def print_grid
        max_x = grid.keys.max
        max_y = grid.values.map(&:keys).flatten.max
        (0...max_y).each do |y_num|
          print "\r\n"
          (0...max_x).each do |x_num|
            print grid.dig(x_num, y_num) || '.'
          end
        end
        puts
      end

      private

      def traverse_line(line, allow_diag: true)
        start_point      = line.start_point
        end_point        = line.end_point
        delta_x, delta_y = line.delta
        return unless diagonals_allowed?(allow_diag, delta_x, delta_y)

        pointer = build_point([start_point.x, start_point.y])
        mark_points(delta_x, delta_y, end_point, pointer)
      end

      def mark_points(delta_x, delta_y, end_point, pointer)
        loop do
          mark_point(pointer)
          increment_pointer(delta_x, delta_y, pointer)
          if pointer.x == end_point.x && pointer.y == end_point.y
            mark_point(pointer)
            break
          end
        end
      end

      def diagonals_allowed?(allow_diag, delta_x, delta_y)
        allow_diag || [delta_x, delta_y].any?(&:zero?)
      end

      def build_point(coord_array)
        point = Struct.new(:x, :y)
        point.new(*coord_array)
      end

      def increment_pointer(delta_x, delta_y, pointer)
        pointer.x = pointer.x + delta_x
        pointer.y = pointer.y + delta_y
      end

      def mark_point(pointer)
        grid.bury(pointer.x, pointer.y, (grid.dig(pointer.x, pointer.y).to_i + 1))
      end
    end

    class CoordinateHash < Hash
      def bury(*args)
        raise ArgumentError, '2 or more arguments required' if args.count < 2

        if args.count == 2
          self[args[0]] = args[1]
        else
          arg       = args.shift
          self[arg] = CoordinateHash.new unless self[arg]
          self[arg].bury(*args) unless args.empty?
        end

        self
      end
    end

    def part_1(input)
      line_segments = parse_input(input)
      grid          = populate_grid(line_segments, allow_diag: false)
      # grid.print_grid
      grid.overlapped_points
    end

    def part_2(input)
      line_segments = parse_input(input)
      grid          = populate_grid(line_segments)
      # grid.print_grid
      grid.overlapped_points
    end

    private

    def parse_input(input)
      parsed_lines = input.lines.map do |line|
        line.strip.split(' -> ').map! { |ln| ln.split(',').map!(&:to_i) }
      end
      parsed_lines.map do |line|
        point_1, point_2 = line.map(&method(:build_point))
        line             = build_line(point_1, point_2)
        line
      end
    end

    def build_point(coord_array)
      point = Struct.new(:x, :y)
      point.new(*coord_array)
    end

    def populate_grid(line_segments, allow_diag: true)
      plane = CoordinatePlane.new
      line_segments.each { |segment| plane.add_line(segment, allow_diag: allow_diag) }
      plane
    end

    def determine_direction(points)
      case points
      when ->(pts) { pts[0].x == pts[1].x }
        :vertical
      when ->(pts) { pts[0].y == pts[1].y }
        :horizontal
      else
        :diagonal
      end
    end

    def determine_delta(point_1, point_2)
      [point_2.x <=> point_1.x, point_2.y <=> point_1.y]
    end

    def build_line(point_1, point_2)
      delta = determine_delta(point_1, point_2)
      line  = Struct.new(:start_point, :end_point, :delta)
      line.new(point_1, point_2, delta)
    end
  end
end
