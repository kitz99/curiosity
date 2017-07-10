class InvalidInstruction < StandardError
  def initialize(message)
    @message = message
  end

  def to_s
    "#{@message} #{super}"
  end
end
