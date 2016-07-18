require_relative './coordinates'
require_relative './colour'
module Commands
  class PaintVerticalLine
    include Coordinates, Painting::Colour
    USAGE =
        "V - paint vertical line
       X - column (must be between 1 and 250)
       Y1 - starting row (must be between 1 and 250)
       Y2 - finishing row (must be between 1 and 250)
       C - colour (must be between 'A' to 'Z')
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else
        colour = args[3]
        from = Point.new(x: args[0].to_i, y: args[1].to_i)
        to = Point.new(x: args[0].to_i, y: args[2].to_i)
        vertical_line(from, to).each do |point|
          @canvas.paint(point: point, colour: colour)
        end
      end
    end

    private

    def invalid?(args)
      starting_point = Point.new(x: args[0].to_i, y: args[1].to_i)
      finishing_point = Point.new(x: args[0].to_i, y: args[2].to_i)
      colour = args[3]
      args.size < 4 or
          !starting_point.within_bounds? or
          !finishing_point.within_bounds? or
          unavailable?(colour)
    end

    def vertical_line(from, to)
      start = [from.y, to.y].min
      finish = [from.y, to.y].max
      (start..finish).map { |y_coord| Point.new(x: from.x, y: y_coord) }
    end
  end
end
