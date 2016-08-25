require_relative './coordinates'
require_relative './colour'
module Commands
  class ColourPixel
    include Coordinates, Painting::Colour

    def initialize canvas
      @canvas = canvas
    end

    def run args
      point = Point.new(x: args[0].to_i, y: args[1].to_i)
      @canvas.paint(point: point, colour: args[2])
    end
  end
end
