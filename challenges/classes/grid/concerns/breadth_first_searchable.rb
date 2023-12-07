module BreadthFirstSearchable
  def self.included(base)
    super
    base.class_eval do
      class << self
        attr_accessor :bfs_eligibility_proc
      end

      self.bfs_eligibility_proc = lambda { |point|
        return false if point.nil?

        true
      }
    end
  end

  private

  def bfs(point)
    queue   = [point]
    visited = { point => [] }
    loop do
      current = queue.pop
      yield(current, visited, queue, point)
      break visited if queue.empty?
    end
  end

  def bfs_eligible_neighbors(point, include_diagonal)
    neighbors_for_point(point, include_diagonal:).select do |neighbor|
      next false if neighbor.nil?
      next false if self.class.bfs_eligibility_proc.nil?

      self.class.bfs_eligibility_proc.call(neighbor)
    end
  end
end
