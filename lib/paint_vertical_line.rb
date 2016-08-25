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
      Point.vertical_line(from, to).each do |point|
        @canvas.paint(point: point, colour: colour)
      end
    end
  end
end
