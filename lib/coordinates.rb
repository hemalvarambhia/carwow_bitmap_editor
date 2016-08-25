module Coordinates
  class Point
    attr_reader :x, :y
    
    def initialize(coords)
      @x = coords[:x]
      @y = coords[:y]
    end

    def self.vertical_line(from, to)
      start = [from.y, to.y].min
      finish = [from.y, to.y].max
      (start..finish).map { |y_coord| Point.new(x: from.x, y: y_coord) }
    end

    def self.horizontal_line(from, to)
      start = [from.x, to.x].min
      finish = [from.x, to.x].max
      (start..finish).map { |x_coord| Point.new(x: x_coord, y: from.y) }
    end

    def within_bounds?
      @x.between?(1, 250) and @y.between?(1, 250)
    end

    def ==(other)
      x == other.x and y == other.y
    end
  end
end
