require_relative 'robot_helpers'
require_relative 'constants'

class Robot
  attr_reader :x, :y, :facing, :commands, :x_bound, :y_bound
  include Constants
  include RobotHelpers

  def initialize(raw_commands, x_bound, y_bound)
    @x_bound, @y_bound = [x_bound, y_bound]
    @commands = clear_commands(raw_commands)
    place = build_place_instruction(@commands.first)
    @x, @y, @facing = place.values
  end

  def call
    last_report = ''
    @commands[1..-1].each do |raw_instruction|
      last_report = process(raw_instruction)
    end
    last_report
  end

  def process(raw_instruction)
    if raw_instruction.start_with?("PLACE")
      self.current_position = build_place_instruction(raw_instruction, true)
      return
    end

    case raw_instruction
    when 'MOVE'
      move
    when 'LEFT'
      change_orientation('LEFT')
    when 'RIGHT'
      change_orientation('RIGHT')
    when 'REPORT'
      report
    else
      return
    end
  end

  private

  def current_position=(values)
    temp_x = values[:x].to_i if values[:x]
    temp_y = values[:y].to_i if values[:y]
    temp_f = values[:facing].upcase if values[:facing]

    if (0..x_bound).include?(temp_x) && (0..y_bound).include?(temp_y)
      @x = temp_x
      @y = temp_y
      @facing = temp_f
    end
  end

  def report
    %Q[#{x}, #{y}, #{facing}]
  end

  def move
    dx, dy = current_movement
    self.current_position = { x: x + dx, y: y + dy, facing: @facing }
  end

  def change_orientation(direction)
    @facing = DIRECTIONS[@facing.to_sym][direction.upcase.to_sym]
  end
end
