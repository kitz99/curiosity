require "minitest/autorun"
require_relative "../main"

describe Main do
  describe "when valid configuration" do
    it "must return 3,3,NORTH" do
      @main = Main.new("tests/files/valid_configuration.txt")
      response = @main.parse
      response.must_equal "3, 3, NORTH"
    end

    it "must return 5,5,SOUTH" do
      @main = Main.new("tests/files/4_4_SOUTH.txt")
      response = @main.parse
      response.must_equal "4, 4, SOUTH"
    end

    it "must return 0,0,WEST" do
      @main = Main.new("tests/files/0_0_WEST.txt")
      response = @main.parse
      response.must_equal "0, 0, WEST"
    end

    it "must return 3, 0, NORTH" do
      @main = Main.new("tests/files/road.txt")
      response = @main.parse
      response.must_equal "3, 0, NORTH"
    end

  end

  describe "configuration starst with another instruction" do
    it "must return 3,3,NORTH" do
      @main = Main.new("tests/files/another_instruction.txt")
      response = @main.parse
      response.must_equal "3, 3, NORTH"
    end
  end

  describe "Invalid PLACE" do
    it "must THROW Exception" do
      @main = Main.new("tests/files/invalid_place.txt")
      assert_raises InvalidInstruction do
        @main.parse
      end
    end
  end

  describe "out of map" do
    it "must return 4, 0, EAST" do
      @main = Main.new("tests/files/4_0_EAST.txt")
      response = @main.parse
      response.must_equal "4, 0, EAST"
    end
  end
end