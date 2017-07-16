require 'active_support'
require_relative 'robot'

class Main
  def initialize(x_bound, y_bound, input_file_name='input.txt')
    @input_file = File.open(input_path(input_file_name))
    @x_bound = x_bound
    @y_bound = y_bound
  end

  def parse
    raw_instructions = @input_file.readlines.map(&:strip)
    robot = Robot.new(raw_instructions, @x_bound, @y_bound)
    puts robot.call
  end

  private

  def input_path(input_file_name)
    File.join(File.dirname(__FILE__), input_file_name)
  end
end

Main.new(4, 4).parse
