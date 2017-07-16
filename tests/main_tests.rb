require "minitest/autorun"
require_relative "../robot"
require_relative "../exceptions/invalid_instruction"

def lines_from(file_name)
  File.open(file_name, 'r').readlines.map(&:strip)
end

describe Robot do
  describe "when valid configuration" do
    it "must return 3,3,NORTH" do
      lines = lines_from("tests/files/valid_configuration.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "3, 3, NORTH"
    end

    it "must return 4,4,SOUTH" do
      lines = lines_from("tests/files/4_4_SOUTH.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "4, 4, SOUTH"
    end

    it "must return 0,0,WEST" do
      lines = lines_from("tests/files/0_0_WEST.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "0, 0, WEST"
    end

    it "must return 3, 0, NORTH" do
      lines = lines_from("tests/files/road.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "3, 0, NORTH"
    end

  end

  describe "configuration starts with another instruction" do
    it "must return 3,3,NORTH" do
      lines = lines_from("tests/files/another_instruction.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "3, 3, NORTH"
    end
  end

  describe "Invalid PLACE" do
    it "must THROW Exception" do
      lines = lines_from("tests/files/invalid_place.txt")
      assert_raises InvalidInstruction do
        Robot.new(lines, 4, 4).call
      end
    end
  end

  describe "out of map" do
    it "must return 4, 0, EAST" do
      lines = lines_from("tests/files/4_0_EAST.txt")
      response = Robot.new(lines, 4, 4).call
      response.must_equal "4, 0, EAST"
    end
  end
end