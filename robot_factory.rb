require_relative 'utils'

class RobotFactory
  include Utils

  def self.build_robot(line)
    Robot.new(*Utils.build_place_instruction(line).values)
  end
end
