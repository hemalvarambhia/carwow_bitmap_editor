require_relative './coordinates'
require_relative './colour'
module Commands
  class PaintHorizontalLine
    include Coordinates, Painting::Colour
    USAGE =
        "H - paint horizontal line
       X1 - starting column (must be between 1 and 250)
       X2 - finishing column (must be between 1 and 250)
       Y - row (must be between 1 and 250)
       C - colour (must be between 'A' to 'Z')
      "

    def initialize(canvas)
      @canvas = canvas
    end

    def run args
      colour = args[3]
      from = Point.new(x: args[0].to_i, y: args[2].to_i)
      to = Point.new(x: args[1].to_i, y: args[2].to_i)
      horizontal_line(from, to).each do |point|
        @canvas.paint(point: point, colour: colour)
      end
    end

    private

    def horizontal_line(from, to)
      start = [from.x, to.x].min
      finish = [from.x, to.x].max
      (start..finish).map { |x_coord| Point.new(x: x_coord, y: from.y) }
    end
  end
end
