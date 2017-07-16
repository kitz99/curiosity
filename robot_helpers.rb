module RobotHelpers

  private

  def clear_commands(lines)
    result = []
    found_initial = false
    lines.each do |line|
      line.start_with?("PLACE") ? found_initial = true : nil
      result << line if Constants::VALID_COMMANDS.include?(line.split(' ').first) && found_initial
    end

    result
  end

  def build_place_instruction(line, initialized=false)
    parts = line.split(' ')
    raise InvalidInstruction.new('Invalid initial instruction. Abort!') unless parts.first == 'PLACE'

    position = Array(parts.last&.split(','))
    raise InvalidInstruction.new('Not valid coordinates') unless position.size == 3

    unless initialized
      raise InvalidInstruction.new('Not valid X coordinate') unless (0..@x_bound).include?(position[0].to_i)
      raise InvalidInstruction.new('Not valid Y coordinate') unless (0..@y_bound).include?(position[1].to_i)
      raise InvalidInstruction.new('Not valid facing') unless Constants::FACINGS.include?(position[2])
    end

    { x: position[0].to_i, y: position[1].to_i, facing: position[2] }
  end

  def current_movement
    Constants::MOVEMENTS[@facing.to_sym]
  end
end
