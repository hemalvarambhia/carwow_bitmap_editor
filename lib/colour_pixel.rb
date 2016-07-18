require_relative './coordinates'
require_relative './colour'
module Commands
  class ColourPixel
    include Coordinates, Painting::Colour
    USAGE =
        "L - Colour in a pixel
       X - column (must be between 1 and 250)
       Y - row (must be between 1 and 250)
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
        point = Point.new(x: args[0].to_i, y: args[1].to_i)
        @canvas.paint(point: point, colour: args[2])
      end
    end

    private

    def invalid?(args)
      point = Point.new(x: args[0].to_i, y: args[1].to_i)
      colour = args[2]
      args.size < 3 or
          !point.within_bounds? or
          unavailable?(colour)
    end
  end
end
