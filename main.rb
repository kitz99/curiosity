require 'active_support'
require_relative 'robot'
require_relative 'robot_factory'
require_relative 'exceptions/invalid_instruction'
require_relative 'utils'

class Main
  VALID_COMMANDS = %w(
    PLACE MOVE LEFT RIGHT REPORT
  )
  def initialize(input_file_name='input.txt')
    @input_file = File.open(input_path(input_file_name))
  end

  def parse
    content = clear_content(@input_file.readlines.map(&:strip))
    @robot = RobotFactory.build_robot(content.first)
    last_report = ''
    content[1..-1].each do |raw_instruction|
      last_report = @robot.process(raw_instruction)
    end
    last_report
  end

  private

  def input_path(input_file_name)
    File.join(File.dirname(__FILE__), input_file_name)
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
if ENV['PROD']
  Main.new.parse
end
