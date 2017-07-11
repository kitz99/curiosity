require_relative 'utils'
require_relative 'constants'

class Robot
  include Utils
  include Constants
  attr_accessor :x, :y, :facing

  def initialize(x, y, facing)
    @x = x.to_i
    @y = y.to_i
    @facing = facing
  end

  def report
    response =  %Q[#{x}, #{y}, #{facing}]
    puts response
    response
  end

  def current_position=(values)
    temp_x = values[:x].to_i if values[:x]
    temp_y = values[:y].to_i if values[:y]
    temp_f = values[:facing].upcase if values[:facing]

    if (0..4).include?(temp_x) && (0..4).include?(temp_y)
      @x = temp_x
      @y = temp_y
      @facing = temp_f
    end
  end

  def process(raw_instruction)
    if raw_instruction.start_with?("PLACE")
      self.current_position = Utils.build_place_instruction(raw_instruction, true)
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

  def current_movement
    MOVEMENTS[facing]
  end

  def move
    dx, dy = current_movement
    temp_x = x + dx
    temp_y = y + dy
    if (0..4).include?(temp_x) && (0..4).include?(temp_y)
      @x = temp_x
      @y = temp_y
    end
  end

  def change_orientation(direction)
    @facing = DIRECTIONS[facing][direction]
  end
end
