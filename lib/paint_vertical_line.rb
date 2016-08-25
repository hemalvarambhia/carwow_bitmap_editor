require_relative './coordinates'
require_relative './colour'
module Commands
  class PaintVerticalLine
    include Coordinates

    def initialize(canvas)
      @canvas = canvas
    end

    def run args
      colour = args[3]
      from = Point.new(x: args[0].to_i, y: args[1].to_i)
      to = Point.new(x: args[0].to_i, y: args[2].to_i)
      vertical_line(from, to).each do |point|
        @canvas.paint(point: point, colour: colour)
      end
    end

    private

    def vertical_line(from, to)
      start = [from.y, to.y].min
      finish = [from.y, to.y].max
      (start..finish).map { |y_coord| Point.new(x: from.x, y: y_coord) }
    end
  end
end
