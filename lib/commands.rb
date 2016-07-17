require_relative './coordinates'
require_relative './colour'
module Commands
  class SetupCanvas
    USAGE =
      "I - set up a canvas
       M - width (must be between 1 and 250)
       N - height (must be between 1 and 250)
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else
        @canvas.blank(width: args.first.to_i, height: args[1].to_i)
      end
    end

    private

    def invalid? args
      width = args.first.to_i
      height = args[1].to_i
      args.size < 2 or !width.between?(1, 250) or !height.between?(1, 250)
    end
  end

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
       params = {
          column: args[0].to_i, row: args[1].to_i, colour: args[2]
        }
        @canvas.paint params
      end
    end

    private

    def invalid?(args)
      point = Point.new(x: args[0].to_i, y: args[0].to_i)
      colour = args[2]
      args.size < 3 or
        !point.within_bounds? or
        unavailable?(colour)
    end
  end

  class ClearCanvas
    def initialize canvas
      @canvas = canvas
    end

    def run args
      @canvas.clear
    end
  end

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
          params = {row: point.y, column: point.x}.merge(colour: colour)
          @canvas.paint params
        end
      end
    end

    private

    def invalid?(args)
      column = args[0].to_i
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

  class PaintHorizontalLine
    include Coordinates, Painting::Colour
    USAGE =
      "H - paint horizontal line
       X1 - starting column (must be between 1 and 250)
       X2 - finishing column (must be between 1 and 250)
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
        colour = args[3]
        from = Point.new(x: args[0].to_i, y: args[2].to_i)
        to = Point.new(x: args[1].to_i, y: args[2].to_i)
        horizontal_line(from, to).each do |point|
          params = {column: point.x, row: point.y}.merge(colour: colour)
          @canvas.paint params
        end
      end
    end

    private

    def invalid?(args)
      colour = args[3]
      starting_point = Point.new(x: args[0].to_i, y: args[2].to_i)
      finishing_point = Point.new(x: args[1].to_i, y: args[2].to_i)
      args.size < 4 or
        !starting_point.within_bounds? or
        !finishing_point.within_bounds? or
        unavailable?(colour)
    end

    def horizontal_line(from, to)
      start = [from.x, to.x].min
      finish = [from.x, to.x].max
      (start..finish).map { |x_coord| Point.new(x: x_coord, y: from.y) }
    end
  end

  class ExitEditor
    def run *args
      exit
    end
  end

  class DisplayCanvas
    def initialize(output, canvas)
      @output = output
      @canvas = canvas
    end

    def run *args
      @output.puts @canvas
    end
  end

  class Help
    HELP = "? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session"

    def initialize output, text = HELP
      @output = output
      @text = text
    end

    def run *args
      @output.puts @text
    end
  end
end
