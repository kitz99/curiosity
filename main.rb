require 'active_support'
require_relative 'robot'
require_relative 'robot_factory'
require_relative 'exceptions/invalid_instruction'
require_relative 'utils'

class Main
  VALID_COMMANDS = %w(
    PLACE MOVE LEFT RIGHT REPORT
  )
  def initialize
    @input_file = File.open(input_path)
  end

  def parse
    content = clear_content(@input_file.readlines.map(&:strip))
    @robot = RobotFactory.build_robot(content.first)
    content[1..-1].each do |raw_instruction|
      @robot.process(raw_instruction)
    end
  end

  private

  def input_path
    File.join(File.dirname(__FILE__), 'input.txt')
  end

  def clear_content(lines)
    result = []
    found_initial = false
    lines.each do |line|
      line.start_with?("PLACE") ? found_initial = true : nil
      result << line if VALID_COMMANDS.include?(line.split(' ').first) && found_initial
    end

    result
  end
end

# start script
Main.new.parse
