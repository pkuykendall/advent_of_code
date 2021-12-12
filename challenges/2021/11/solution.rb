# frozen_string_literal: true

module Year2021
  class Day11
    class Octomap < Grid
      class Octopus < Grid::Point
        attr_accessor :flashed, :flash_count

        def initialize(x_idx, y_idx, value, color)
          super
          @flash_count = 0
        end

        def increment
          self.flashed = true if value == 9
          self.value += 1
        end

        def reset
          return unless value > 9

          self.value       = 0
          self.flashed     = false
          self.flash_count += 1
          @just_flashed    = false
          self
        end

        def should_propagate?
          value == 10
        end

        def flashed?
          !!flashed
        end

        def just_flashed?
          if @just_flashed
            false
          else
            @just_flashed = flashed?
          end
        end
      end

      self.point_class = Octopus

      def run_steps(num_steps)
        num_steps.times do
          step_through_octopuses
        end
      end

      def steps_until_sync
        (1..1000).find do |step|
          run_steps(1)
          break step if all? { |line| line.all? { |point| point.value.zero? } }
        end
      end

      private

      def step_with_prep
        each_element(&:increment)
        flashed_octopuses = map { |line| line.select(&:flashed?) }.flatten
        yield(flashed_octopuses)
        each_element(&:reset)
      end

      def step_through_octopuses
        step_with_prep do |flashed_octopuses|
          flashed_octopuses.each do |prime_flasher|
            bfs(prime_flasher) do |current, _visited, queue, _starting_point|
              find_neighbors(current, queue)
            end
          end
        end
      end

      def find_neighbors(current, queue)
        return unless current.just_flashed?

        eligible_neighbors(current, true).each do |neighbor|
          neighbor.increment
          queue << neighbor
        end
      end
    end

    def part_1(input)
      octomap = generate_octomap(input)
      octomap.run_steps(100)
      octomap.map { |line| line.map(&:flash_count).flatten }.flatten.sum
    end

    def part_2(input)
      octomap = generate_octomap(input)
      octomap.steps_until_sync
    end

    private

    def generate_octomap(input)
      octomap = input.lines.map do |line|
        line.strip.chars
      end

      Octomap.new(octomap)
    end
  end
end
