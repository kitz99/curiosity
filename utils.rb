module Utils
  module_function

  def build_place_instruction(line)
    parts = line.split(' ')
    raise InvalidInstruction.new('Invalid initial instruction. Abort!') unless parts.first == 'PLACE'

    position = Array(parts.last&.split(','))
    raise InvalidInstruction.new('Not valid coordinates') unless position.size == 3

    raise InvalidInstruction.new('Not valid X coordinate') unless (0..4).include?(position[0].to_i)
    raise InvalidInstruction.new('Not valid Y coordinate') unless (0..4).include?(position[1].to_i)
    raise InvalidInstruction.new('Not valid facing') unless (0..4).include?(position[2].to_i)

    { x: position[0], y: position[1], facing: position[2] }
  end
end
