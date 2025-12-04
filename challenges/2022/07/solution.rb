# frozen_string_literal: true

# LAZY_HASH = ->(h, k) { h[k] = Hash.new(&LAZY_HASH) }.freeze
module Year2022
  class Day07 < Solution
    class Directory
      class << self
        attr_accessor :file_class
      end

      self.file_class = Struct.new(:name, :size)

      attr_accessor :parent, :name, :children, :size

      def initialize(parent:, name:)
        @parent = parent
        @name = name
        @children = []
        @size = 0
      end

      def add_file(name, file_size)
        file = self.class.file_class.new(name, file_size)
        increase_size(file_size)
        children << file
      end

      def add_subdirectory(name)
        children << self.class.new(parent: self, name:)
      end

      def increase_size(file_size)
        @size += file_size
        parent&.increase_size(file_size)
        file_size
      end
    end

    class FileSystem
      attr_reader :current_directory, :root_directory

      def initialize
        @root_directory = @current_directory = Directory.new(parent: nil, name: '/')
      end

      def add_directory(name)
        current_directory.add_subdirectory(name)
      end

      def add_file(name, size)
        current_directory.add_file(name, size)
      end

      def cd(path)
        # puts "CD: #{path}"
        directory_pointer = current_directory
        # puts "Current Directory: #{current_directory.name}"
        path.split('/').each do |path_part|
          # puts "Searching Directory: #{path_part}"
          directory_pointer = case path_part
                              when '..'
                                directory_pointer.parent
                              else

                                directory_pointer.children.find { |child| child.name == path_part }
                                # puts "Changing Directory: #{directory_pointer.name}"
                              end
        end
        # puts "Final Directory: #{directory_pointer.name}"
        @current_directory = directory_pointer
      end

      private

      attr_writer :current_directory
    end

    def part_1
      @file_system = FileSystem.new
      parse_input

      output = select_directories(file_system.root_directory, 100_000)
      output.sum(&:size)
    end

    def part_2
      nil
    end

    private

    attr_reader :file_system

    def parse_input
      data.each do |line|
        if line.start_with? '$'
          do_system_command(line)
        else
          parse_output(line)
        end
      end
    end

    def do_system_command(line)
      _sys, command, arg = line.split
      case command
      when 'cd'
        file_system.cd(arg)
      when 'ls'
        # no-op
      else
        # no-op
      end
    end

    def parse_output(line)
      if line.start_with?(/\d+/)
        size, name = line.split
        file_system.add_file(name, size.to_i)
      elsif line.start_with?('dir')
        _dir, name = line.split
        file_system.add_directory(name)
      end
    end

    def select_directories(directory, max_size)
      directory.children.map do |child|
        if child.is_a? Directory
          sub_dirs = select_directories(child, max_size)
          Array(child) + sub_dirs if child.size < max_size
        end
      end.compact.flatten
    end

    def find_size(directory)
      directory.children.sum do |child|
        next 0 unless child.is_a? Directory

        next 0 if child.size > 100_000

        return child.size + find_size(child)
      end
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
