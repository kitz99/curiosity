module Utils
  module_function

  def build_place_instruction(line)
    parts = line.split(' ')
    raise InvalidInstruction.new('Invalid initial instruction. Abort!') unless parts.first == 'PLACE'

    position = Array(parts.last&.split(','))
    raise InvalidInstruction.new('Not valid coordinates') unless position.size == 3

    { x: position[0], y: position[1], facing: position[2] }
  end
end
